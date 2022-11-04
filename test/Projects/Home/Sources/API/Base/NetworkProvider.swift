//
//  Provider.swift
//  DabangPro
//
//  Created by Ickhwan Ryu on 2020/04/14.
//  Copyright © 2020 Ickhwan Ryu. All rights reserved.
//

//import Alamofire

import Moya
import RxSwift
import Foundation
import RxRelay

protocol MoyaServiceType {
    associatedtype API: APIType
    
    var provider: MoyaProvider<API> { get }
    func request<S, F>(_ target: API) -> Single<ApiResult<S, F>> where S: Decodable, F: ApiFailResponseType
    func request<S, F>(_ target: API, isErrorHandling: Bool) -> Single<ApiResult<S, F>> where S: Decodable, F: ApiFailResponseType
    func request(_ target: API) -> Single<ApiPlainResponse>
}

final class NetworkProvider<T: APIType>: MoyaServiceType {
    private var disposeBag = DisposeBag()
    
    let provider: MoyaProvider<T>
    
    let networkClosure = {(_ change: NetworkActivityChangeType, _ target: TargetType) in
        switch change {
        case .began:
            DBLog(" - - - - - - - - - - - - - - - - - - Request Start - - - - - - - - - - - - - - - -\n")
        case .ended:
            DBLog(" - - - - - - - - - - - - - - - - - - Request End - - - - - - - - - - - - - - - - -\n")
        }
    }
    
    init() {
        var config = NetworkLoggerPlugin.Configuration()
        let optionSet: NetworkLoggerPlugin.Configuration.LogOptions = [.formatRequestAscURL]
        config.logOptions = optionSet
        
        provider = MoyaProvider<T>(plugins: [ APILoggingPlugin(),
                                              NetworkActivityPlugin(networkActivityClosure: networkClosure) ])
    }
    
//    func request<D: Decodable>(_ target: T, type: D.Type) -> Single<D> {
//        return provider.rx.request(target)
//        .filterSuccessfulStatusCodes()
//        .map(type)
//    }
//
//    func request(_ target: T) -> Single<Response> {
//        return provider.rx.request(target)
//    }
    
    func request(_ target: T) -> Single<ApiPlainResponse> {
        let single = Single<ApiPlainResponse>.create { [weak self] single in
            guard let self = self else {
                single(.success(ApiPlainResponse(code: -1, result: nil)))
                return Disposables.create()
            }
            
            let provider = self.provider(target)
            provider.rx.request(target).subscribe{ event in
                switch event {
                case .success(let resp):
                    let plainResp = String(decoding: resp.data, as: UTF8.self)
                    let result = ApiPlainResponse(code: resp.statusCode, result: plainResp)
                    
                    single(.success(result))
                    
                case .failure(let error):
                    guard let moyaError = error as? MoyaError else {
                        single(.success(ApiPlainResponse(code: -1, result: nil)))
                        return
                    }
                    
                    if let resp = moyaError.response {
                        let plainResp = String(decoding: resp.data, as: UTF8.self)
                        single(.success(ApiPlainResponse(code: resp.statusCode, result: plainResp)))
                        return
                    }
                    
                    single(.success(ApiPlainResponse(code: -1, result: moyaError.errorDescription)))
                    
    //                switch moyaError {
    //                case .underlying(let error, _):
    //                    if let afError = error.asAFError {
    //
    //                    }
    //
    //                default:
    //                    network.onNext(ApiPlainResponse(code: -1, result: moyaError.errorDescription))
    //                }
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
        
        return single
    }
    
    func request<S, F>(_ target: T) -> Single<ApiResult<S, F>> where S: Decodable, F: ApiFailResponseType {
        return request(target, isErrorHandling: false)
    }
    
    func request<S, F>(_ target: T, isErrorHandling: Bool) -> Single<ApiResult<S, F>> where S: Decodable, F: ApiFailResponseType {
//        guard NetworkFlow.unusableNetwork == false else { return .never() }
        
        let single = Single<ApiResult<S, F>>.create { [weak self] single in
            guard let self = self else {
//                    single(.success(ApiResult<S, F>(result: .failure(model))))
//                    single(.success(ApiPlainResponse(code: -1, result: nil)))
                return Disposables.create()
            }
        
            let provider = self.provider(target)
            provider.rx.request(target).subscribe{ event in
                switch event {
                case .success(let resp):
                    guard let sData = try? resp.filterSuccessfulStatusCodes() else {
                        do {
                            let model = try resp.map(F.self, atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false)
                            single(.failure(model))
                        } catch let error {
                            single(.failure(F.init(error: error)))
                        }
                        return
                    }

                    do {
                        let model = try sData.map(ApiSuccessResponse<S>.self, atKeyPath: nil, using: JSONDecoder(), failsOnEmptyData: false)
                        
                        single(.success(ApiResult<S, F>(result: .success(model))))
                    }  catch let DecodingError.dataCorrupted(context) {
                        DBLog("\(context)")
                        single(.failure(F.init(error: DecodingError.dataCorrupted(context))))
                    } catch let DecodingError.keyNotFound(key, context) {
                        DBLog("Key '\(key)' not found:", context.debugDescription)
                        DBLog("codingPath:", context.codingPath)
                        single(.failure(F.init(error: DecodingError.keyNotFound(key, context))))
                    } catch let DecodingError.valueNotFound(value, context) {
                        DBLog("Value '\(value)' not found:", context.debugDescription)
                        DBLog("codingPath:", context.codingPath)
                        single(.failure(F.init(error: DecodingError.valueNotFound(value, context))))
                    } catch let DecodingError.typeMismatch(type, context)  {
                        DBLog("Type '\(type)' mismatch:", context.debugDescription)
                        DBLog("codingPath:", context.codingPath)
                        single(.failure(F.init(error: DecodingError.typeMismatch(type, context))))
                    } catch {
                        DBLog("error: \(error)")
                        single(.failure(F.init(error: error)))
                    }
                case .failure(let error):
                    single(.failure(F.init(error: error)))
                }
            }
            .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .default))
        .catch { error in
//            if let error = error as? ApiFailResponseType,
//                NetworkFlowManager.current.checkNetworkTypeError(error: error) == false {
//                return .never()
//            }
//
            if isErrorHandling {
                return .error(error)
            }
            
            return .just(ApiResult<S, F>(result: .failure(error as! F)))
        }
        
        return single
    }
        
    private func provider(_ target: T) -> MoyaProvider<T> {
//        guard let timeout = target.timeout else { return provider }
        
        var config = NetworkLoggerPlugin.Configuration()
        let optionSet: NetworkLoggerPlugin.Configuration.LogOptions = [.formatRequestAscURL]
        config.logOptions = optionSet
        
        let configuration = URLSessionConfiguration.default
//        configuration.timeoutIntervalForRequest = timeout
//        configuration.timeoutIntervalForResource = timeout
        
        let session = Session(configuration: configuration)
        
        return MoyaProvider<T>(session: session,
                               plugins: [ APILoggingPlugin(),
                                          NetworkActivityPlugin(networkActivityClosure: networkClosure) ])
    }
}

extension PrimitiveSequence where Trait == SingleTrait, Element: Response {
    func bindResponse<S: Decodable, F: Decodable>(_ success: PublishRelay<S>, _ fail: PublishRelay<F>) -> MultiDisposable {
        let shared = (asObservable() as! Observable<Response>).share()
        let disposables = MultiDisposable()
        
        let success = shared.filterSuccessfulStatusCodes().map(S.self).subscribe(onNext: { data in
                success.accept(data)
            }, onError: { _ in
                
            })
//            .bind(to: success)
        
        let failServer = shared.filter(statusCode: 400).map(F.self).subscribe(onNext: { error in
                fail.accept(error)
            }, onError: { _ in
                
            })
//            .bind(to: fail)
        
        disposables.add([success, failServer])
        
        return disposables
    }
}

class MultiDisposable {
    var disposables: [Disposable] = []
    
    func add(_ disposables: [Disposable]) {
        self.disposables.append(contentsOf: disposables)
    }
    
    func disposed(by disposeBag: DisposeBag) {
        disposables.forEach { $0.disposed(by: disposeBag) }
        disposables.removeAll()
    }
}
