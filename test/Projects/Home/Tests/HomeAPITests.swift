//
//  HomeAPITests.swift
//  Home
//
//  Created by choidam on 2022/09/01.
//  Copyright © 2022 team.io. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxNimble
import Nimble

@testable import Home

class HomeAPITests: XCTestCase {
    
    // MARK: Property
    
    private var provider: HomeAPIProvider!
    private var reactor: HomeViewReactor!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        provider = HomeAPIProvider(isStub: true)
        reactor = HomeViewReactor(homeProvider: provider)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func test_fetch() {
        
        let expectation = XCTestExpectation()
        let response = try? JSONDecoder().decode(UserResponse.self,
                                                 from: HomeAPI.getUser.sampleData)
            
           
    }
}
