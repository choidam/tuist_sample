//
//  GithubAPI.swift
//  Home
//
//  Created by choidam on 2022/11/03.
//  Copyright © 2022 team.io. All rights reserved.
//

import Moya
import Foundation
import Alamofire

enum GithubAPI {
    case getUser
}

extension GithubAPI: APIType {
    var baseURL: URL {
        let url = "https://api.github.com"
        return URL(string: url)!
    }
    
    var path: String {
        switch self {
        case .getUser:
            return "/users/choidam"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getUser:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getUser:
            return taskObject([:])
        }
    }
}
