//
//  GitApiService.swift
//  Home
//
//  Created by choidam on 2022/11/03.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol GitApiServiceType {
    func reqUserInfo() -> Observable<ApiResult<GitUser, ApiFailResponse>>
}

struct GitApiService<I: MoyaServiceType>: GitApiServiceType where I.API == GithubAPI {
    let provider: I
    
    init(provider: I) {
        self.provider = provider
    }
    
    func reqUserInfo() -> RxSwift.Observable<ApiResult<GitUser, ApiFailResponse>> {
        return provider.request(.getUser).asObservable()
    }
}
