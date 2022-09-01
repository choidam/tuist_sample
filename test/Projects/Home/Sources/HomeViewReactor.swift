//
//  HomeViewReactor.swift
//  Home
//
//  Created by choidam on 2022/08/29.
//  Copyright © 2022 team.io. All rights reserved.
//

import ReactorKit
import Foundation
import Moya

final class HomeViewReactor: Reactor {
    enum Action {
        case plus
        case minus
        
        case getUser
    }
    
    enum Mutation {
        case plus
        case minus
        
        case getUser
    }
    
    struct State {
        var count: Int = 0
    }
    
    var initialState: State
    
    fileprivate let stubProvider = MoyaProvider<HomeAPI>(stubClosure: MoyaProvider.delayedStub(0))
    
    init() {
        self.initialState = State()
        
        action.onNext(.getUser)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .plus:
            return .just(.plus)
        case .minus:
            return .just(.minus)
        case .getUser:
            return .just(.getUser)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .plus:
            state.count += 1
        case .minus:
            state.count -= 1
        case .getUser:
            stubProvider.request(.getUser) { result in
                switch result {
                case .success(let response):
                    do {
                        let decoder = JSONDecoder()
                        let decodedData = try decoder.decode(UserResponse.self, from: response.data)
                        let user = decodedData.value
                        
                        print("user: \(user)")
                    }
                    catch(let error) {
                        print("decode erorr: \(error)")
                    }
                case .failure(let error):
                    print("error: \(error)")
                }
            }
            
        }
        
        return state
    }
}
