//
//  HomeViewReactor.swift
//  Home
//
//  Created by choidam on 2022/08/29.
//  Copyright © 2022 team.io. All rights reserved.
//

import ReactorKit

class HomeViewReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
}
