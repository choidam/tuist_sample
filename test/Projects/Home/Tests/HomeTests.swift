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

}
