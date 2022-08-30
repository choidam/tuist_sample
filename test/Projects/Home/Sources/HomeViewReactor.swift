//
//  HomeViewReactor.swift
//  Home
//
//  Created by choidam on 2022/08/29.
//  Copyright © 2022 team.io. All rights reserved.
//

import ReactorKit

final class HomeViewReactor: Reactor {
    enum Action {
        case buttonTap
    }
    
    enum Mutation {
       case buttonTap
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
        case .buttonTap:
            return .just(.buttonTap)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .buttonTap:
            state.count += 1
        }
        
        return state
    }
}
