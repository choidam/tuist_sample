//
//  HomeAPIProvider.swift
//  HomeTests
//
//  Created by choidam on 2022/09/01.
//  Copyright © 2022 team.io. All rights reserved.
//

import Moya
import RxSwift

class HomeAPIProvider: ProviderProtocol {

    typealias T = HomeAPI
    var provider: MoyaProvider<HomeAPI>

    required init(isStub: Bool = false, sampleStatusCode: Int = 200, customEndpointClosure: ((T) -> Endpoint)? = nil) {
        provider = Self.consProvider(isStub, sampleStatusCode, customEndpointClosure)
    }

    func fetchUser() -> Single<User> {
        return request(type: User.self,
                       atKeyPath: "value",
                       target: .getUser)
    }
}


