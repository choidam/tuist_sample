//
//  APILogger.swift
//  MoyaTest
//
//  Created by Ickhwan Ryu on 2020/04/08.
//  Copyright © 2020 Ickhwan Ryu. All rights reserved.
//

import Moya
import Foundation

final class APILoggingPlugin: PluginType {
    
    func willSend(_ request: RequestType, target: TargetType) {
        
        let headers = request.request?.allHTTPHeaderFields ?? [:]
        let url = request.request?.url?.absoluteString ?? "nil"
        
        if let body = request.request?.httpBody {
            let bodyString = String(bytes: body, encoding: String.Encoding.utf8) ?? "nil"
            DBLog("""
                    RequestStartTime - \(Date().debugDescription)
                    URL: \(url)
                    Headers : \(headers)
                    Body: \(bodyString)
                  """)
        } else {
            DBLog("""
                    RequestStartTime - \(Date().debugDescription)
                    Url: \(url)
                    Headers : \(headers)
                    Body: nil
                 """)
        }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        do {
            let response = try result.get()
            let request = response.request
            let url = request?.url?.absoluteString ?? "nil"
            let method = request?.httpMethod ?? "nil"
            let statusCode = response.statusCode
            var bodyString = "nil"
            
            if let data = request?.httpBody, let string = String(bytes: data, encoding: String.Encoding.utf8) {
                bodyString = string
            }
            
            let data = response.data
            let responseString = JSONResponseDataFormatter(data)
            
            DBLog("""
                    Response - \(method) statusCode: \(statusCode)
                    Url: \(url)
                    Body: \(bodyString)
                    Response: \(responseString))
                  """)
        } catch {
            DBLog("Description: \(error.localizedDescription))")
        }
    }
    
    private func JSONResponseDataFormatter(_ data: Data) -> String {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
}

public func DBLog(_ format: String, _ args: CVarArg..., path: String = #file, lineNumber: Int = #line, function: String = #function) {
    #if DEBUG
    let logs = "\n\n[\(GetFileName(for: path)):\(lineNumber)]" + format
    print(logs)
    #endif
}

private func GetFileName(for path: String) -> String {
    guard let fileName = NSURL(fileURLWithPath: path).lastPathComponent else { return "unknown" }
    return fileName
}
