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
        reactor = HomeViewReactor()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func testCount() throws {
        scheduler
            .createHotObservable([
                .next(1, HomeViewReactor.Action.buttonTap),
                .next(2, HomeViewReactor.Action.buttonTap)
            ])
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        expect(self.reactor.state.map { $0.count })
            .events(scheduler: scheduler, disposeBag: disposeBag)
            .to(equal([
                .next(0, 0),
                .next(1, 1),
                .next(2, 2)
            ]))
    }
}
