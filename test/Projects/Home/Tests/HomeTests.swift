//
//  HomeTests.swift
//  Home
//
//  Created by choidam on 2022/08/29.
//  Copyright © 2022 team.io. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import RxNimble
import Nimble

@testable import Home

class HomeTests: XCTestCase {
    
    // MARK: Property
    
    private var reactor: HomeViewReactor!
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!

    override func setUp() {
        let homeProvider = HomeAPIProvider(isStub: true)
        reactor = HomeViewReactor(homeProvider: homeProvider)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testCount() throws {
        scheduler
            .createColdObservable([
                .next(10, HomeViewReactor.Action.plus),
                .next(20, HomeViewReactor.Action.plus),
                .next(30, HomeViewReactor.Action.plus)
            ])
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        scheduler
            .createColdObservable([
                .next(15, HomeViewReactor.Action.minus)
            ])
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        expect(self.reactor.state.map { $0.count })
            .events(scheduler: scheduler, disposeBag: disposeBag)
            .to(equal([
                .next(0, 0),
                .next(10, 1),
                .next(15, 0),
                .next(20, 1),
                .next(30, 2)
            ]))
    }
    
    func testAPI() throws {
        scheduler.createColdObservable([
            .next(10, HomeViewReactor.Action.getUser)
        ])
        .bind(to: reactor.action)
        .disposed(by: disposeBag)
        
        expect(self.reactor.state.compactMap { $0.user })
            .events(scheduler: scheduler, disposeBag: disposeBag)
            .to(equal([
                .next(10, User(id: 20, name: "김김김"))
            ]))
    }

}
