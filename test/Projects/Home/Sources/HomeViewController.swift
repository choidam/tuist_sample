//
//  HomeViewController.swift
//  Home
//
//  Created by choidam on 2022/08/23.
//  Copyright © 2022 cocaine.io. All rights reserved.
//

import CommonUI

import UIKit
import RxSwift
import RxCocoa
import ReactorKit
import SnapKit
import Then

open class HomeViewController: UIViewController {
    
    // MARK: UI
    
    private let homeButton = UIButton().then {
        $0.setTitle("home button", for: .normal)
        $0.titleLabel?.font = CommonUIFontFamily.Pretendard.bold.font(size: 15)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let homeLabel = UILabel().then {
        $0.font = CommonUIFontFamily.Pretendard.medium.font(size: 15)
        $0.textColor = .black
    }
    
    // MARK: Property
    
    private let reactor: HomeViewReactor
    
    var disposeBag = DisposeBag()
    
    init(reactor: HomeViewReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
        self.bind(reactor: reactor)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
}

extension HomeViewController {
    public static func create() -> HomeViewController? {
        let homeReactor = HomeViewReactor()
        let homeVC = HomeViewController(reactor: homeReactor)
        
        return homeVC
    }
    
    private func initLayout(){
        view.backgroundColor = CommonUIAsset.commonYellow.color
        
        view.addSubview(homeButton)
        view.addSubview(homeLabel)
        
        homeButton.snp.makeConstraints {
            $0.top.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        homeLabel.snp.makeConstraints {
            $0.top.equalTo(homeButton.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
    }
    
    func bind(reactor: HomeViewReactor){
        homeButton.rx.tap
            .map { _ in HomeViewReactor.Action.buttonTap }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.count }
            .map { "\($0)" }
            .bind(to: homeLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
