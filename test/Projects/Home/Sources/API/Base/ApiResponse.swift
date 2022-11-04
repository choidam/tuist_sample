//
//  NetworkServiceError.swift
//  DabangPro
//
//  Created by you dong woo on 2020/05/14.
//  Copyright © 2020 Ickhwan Ryu. All rights reserved.
//

import Moya
import RxMoya
import Foundation

struct ApiResult<Success: Decodable, Fail> where Fail: ApiFailResponseType {
    let result: Result<ApiSuccessResponse<Success>, Fail>
    
    var response: ApiSuccessResponse<Success>? {
        guard case .success(let value) = result else {
            return nil
        }
        
        return value
    }
    
    var success: Success? {
        guard case .success(let value) = result else {
            return nil
        }
        
        return value.result
    }
    
    var fail: Fail? {
        guard case .failure(let error) = result else {
            return nil
        }
        
        return error
    }
    
    init(result: Result<ApiSuccessResponse<Success>, Fail>) {
        self.result = result
    }
}

protocol ApiFailResponseType: Decodable, Error {
    var code: Int { get set }
    var errorDetails: [String]? {get set}
    var msg: String {get set}
    
    init()
    init(error: Error)
}

extension ApiFailResponseType {
    init(error: Error) {
        self.init()
        
        if let error = error as? MoyaError {
            self.code = error.errorCode
            self.msg = "서버 오류가 발생해습니다."
        } else {
            let error = error as NSError
            
            self.code = error.code
            self.msg = "알 수 없는 에러가 발생했습니다. [\(error.code)]"
        }
    }
}

struct ApiSuccessResponse<D: Decodable>: Decodable {
//    let code: Int
    let result: D?
//    let msg: String
}

struct ApiFailResponse: Equatable, ApiFailResponseType {
    var code: Int = 0
    var errorDetails: [String]?
    var msg: String = ""
    var uuid: String? = UUID().uuidString
}

struct ApiPlainResponse {
    var success: Bool {
        return code == 200
    }
    let code: Int
    let result: String?
}

enum ApiHttpCode: Int, Decodable {
    case success = 200
    case validation = 400
    case logout = 401
    case terms = 410
    case invaildRegisterAgain = 411
    case pageRefresh = 412
    case maxTempRoom = 413
    case errorEmptyRoom = 414
    case forcedUpdate = 415
    case urgentInspection = 416
    case nsdiUpdate = 417
    case failSafeAuthConfirm = 418
    case errorAlert = 419
    
    init?(rawValue: Int) {
        switch rawValue {
        case 200: self = .success
        case 400: self = .validation
        case 401: self = .logout
        case 410: self = .terms
        case 411: self = .invaildRegisterAgain
        case 412: self = .pageRefresh
        case 413: self = .maxTempRoom
        case 414: self = .errorEmptyRoom
        case 415: self = .forcedUpdate
        case 416: self = .urgentInspection
        case 417: self = .nsdiUpdate
        case 418: self = .failSafeAuthConfirm
        case 419: self = .errorAlert
        default: self = .validation
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        
        switch value {
        case 200: self = .success
        case 400: self = .validation
        case 401: self = .logout
        case 410: self = .terms
        case 411: self = .invaildRegisterAgain
        case 412: self = .pageRefresh
        case 413: self = .maxTempRoom
        case 414: self = .errorEmptyRoom
        case 415: self = .forcedUpdate
        case 416: self = .urgentInspection
        case 417: self = .nsdiUpdate
        case 418: self = .failSafeAuthConfirm
        case 419: self = .errorAlert
        default: self = .validation
        }
    }
}
