//
//  APIType.swift
//  Home
//
//  Created by choidam on 2022/11/03.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation
import Moya

protocol APIType: TargetType { }

extension APIType {
    var defaultHeaders: [String: String] {
        return ["Authorization": "Bearer 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"]
    }
    
    var headers: [String : String]? {
        return defaultHeaders
    }
    
    var sampleData: Data {
        return Data()
    }
    
    func taskObject(_ data: [String : Any]) -> Task {
        if method == .get {
            return .requestParameters(parameters: data, encoding: URLEncoding(destination: .queryString, arrayEncoding: .noBrackets))
        }
        
        return .requestCompositeParameters(bodyParameters: data,
                                           bodyEncoding: JSONEncoding.default, urlParameters: [:])
    }
        
    func taskObject<E: Encodable>(_ data: E) -> Task {
        do {
            let jsonData = try JSONEncoder().encode(data)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData,
                                                              options: .allowFragments) as! [String: Any]
            
            return taskObject(dictionary)
        }
        catch {
            defer { fatalError("taskObject error") }
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
}

