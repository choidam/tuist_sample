//
//  ProviderProtocol.swift
//  HomeTests
//
//  Created by choidam on 2022/09/01.
//  Copyright © 2022 team.io. All rights reserved.
//

import Moya
import Alamofire
import Foundation
import RxSwift

public protocol ProviderProtocol: class {
    associatedtype T: TargetType

    var provider: MoyaProvider<T> { get set }
    init(isStub: Bool, sampleStatusCode: Int, customEndpointClosure: ((T) -> Endpoint)?)
}

public extension ProviderProtocol {

    static func consProvider(
        _ isStub: Bool = false,
        _ sampleStatusCode: Int = 200,
        _ customEndpointClosure: ((T) -> Endpoint)? = nil) -> MoyaProvider<T> {
            
            let endPointClosure = { (target: T) -> Endpoint in
                let sampleResponseClosure: () -> EndpointSampleResponse = {
                    EndpointSampleResponse.networkResponse(sampleStatusCode, target.sampleData)
                }
                
                return Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: sampleResponseClosure,
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
            return MoyaProvider<T>(
                endpointClosure: customEndpointClosure ?? endPointClosure,
                stubClosure: MoyaProvider.immediatelyStub
            )

//        if isStub == false {
//            return MoyaProvider<T>(
//                endpointClosure: {
//                    MoyaProvider<T>.defaultEndpointMapping(for: $0).adding(newHTTPHeaderFields: Self.headers)
//                },
//                session: DefaultAlamofireSession.shared,
//                plugins: Self.defaultPlugins // ex - logging, network activity indicator
//            )
//        } else {
//            // 테스트 시에 호출되는 stub 클로져
//            let endPointClosure = { (target: T) -> Endpoint in
//                let sampleResponseClosure: () -> EndpointSampleResponse = {
//                    EndpointSampleResponse.networkResponse(sampleStatusCode, target.sampleData)
//                }
//
//                return Endpoint(
//                    url: URL(target: target).absoluteString,
//                    sampleResponseClosure: sampleResponseClosure,
//                    method: target.method,
//                    task: target.task,
//                    httpHeaderFields: target.headers
//                )
//            }
//            return MoyaProvider<T>(
//                endpointClosure: customEndpointClosure ?? endPointClosure,
//                stubClosure: MoyaProvider.immediatelyStub
//            )
//        }
    }
}

//public extension ProviderProtocol {
//    func request<D: Decodable>(type: D.Type, atKeyPath keyPath: String? = nil, target: T) -> Single<D> {
//       
//        provider.request(<#T##target: TargetType##TargetType#>, completion: <#T##Completion##Completion##(_ result: Result<Response, MoyaError>) -> Void#>)
//        
//        
//        provider.rx.request(target)
//            .map(type, atKeyPath: keyPath)
//        // some operators
//    }
//}
