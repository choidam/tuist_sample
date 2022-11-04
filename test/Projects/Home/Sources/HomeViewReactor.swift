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
        case getGitUserInfo
    }
    
    enum Mutation {
        case plus
        case minus
        
        case getUser(Single<User>)
        case getGitUserInfo(ApiResult<GitUser, ApiFailResponse>)
    }
    
    struct State {
        var count: Int = 0
        
        var user: User?
        var gitUser: GitUser?
    }
    
    var initialState: State
    
    private let homeProvider: HomeAPIProvider!
    private let gitApiService: GitApiServiceType
    
    init(homeProvider: HomeAPIProvider, gitApiService: GitApiServiceType) {
        self.initialState = State()
        
        self.homeProvider = homeProvider
        self.gitApiService = gitApiService
        
        action.onNext(.getGitUserInfo)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .plus:
            return .just(.plus)
        case .minus:
            return .just(.minus)
        case .getUser:
            return .just(.getUser(homeProvider.fetchUser()))
        case .getGitUserInfo:
            return gitApiService.reqUserInfo().map(Mutation.getGitUserInfo)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .plus:
            state.count += 1
        case .minus:
            state.count -= 1
        case .getUser(let response):
            response.subscribe(onSuccess: { user in
                state.user = user
                print("sample user: \(user)")
            }, onFailure: { _ in
                print("response fail")
            })
        case .getGitUserInfo(let result):
            print("✅✅✅✅✅ result: \(result)")
            if let success = result.success {
                state.gitUser = success
            }
        }
        
        return state
    }
}
