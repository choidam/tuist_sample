//
//  HomeViewReactor.swift
//  Home
//
//  Created by choidam on 2022/08/29.
//  Copyright © 2022 team.io. All rights reserved.
//

import ReactorKit
import Moya
import Foundation

final class HomeViewReactor: Reactor {
    enum Action {
        case plus
        case minus
    }
    
    enum Mutation {
        case plus
        case minus
    }
    
    struct State {
        var count: Int = 0
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .plus:
            return .just(.plus)
        case .minus:
            return .just(.minus)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .plus:
            state.count += 1
        case .minus:
            state.count -= 1
        }
        
        return state
    }
}
