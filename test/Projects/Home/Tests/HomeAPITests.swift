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
    private var scheduler: TestScheduler!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        provider = HomeAPIProvider(isStub: true)
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }
    
    func test_fetchRandomJokes_success() {
        let expectation = XCTestExpectation()
        let response = try? JSONDecoder().decode(UserResponse.self,
                                                 from: HomeAPI.getUser.sampleData)
            
        
//        let expectation = XCTestExpectation()
//
//        let expectedJoke = JokesAPI
//            .randomJokes("Gro", "Hong", ["nerdy"])
//            .sampleDecodable(JokeReponse.self)?.value
//
//        sut.fetchRandomJoke(firstName: "Gro", lastName: "Hong", categories: ["nerdy"])
//            .subscribe(onSuccess: { joke in
//                XCTAssertEqual(expectedJoke?.joke, joke.joke)
//                expectation.fulfill()
//            })
//            .dispose()
//        wait(for: [expectation], timeout: 2.0)
           
    }
}
