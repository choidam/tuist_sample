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
    
    private let plusButton = UIButton().then {
        $0.setTitle("plus", for: .normal)
        $0.titleLabel?.font = CommonUIFontFamily.Pretendard.bold.font(size: 20)
        $0.setTitleColor(CommonUIAsset.black.color, for: .normal)
    }
    
    private let minusButton = UIButton().then {
        $0.setTitle("minus", for: .normal)
        $0.titleLabel?.font = CommonUIFontFamily.Pretendard.bold.font(size: 20)
        $0.setTitleColor(CommonUIAsset.black.color, for: .normal)
    }
    
    private let countLabel = UILabel().then {
        $0.font = CommonUIFontFamily.Pretendard.medium.font(size: 20)
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
    
    private func addViews(){
        view.addSubview(plusButton)
        view.addSubview(minusButton)
        view.addSubview(countLabel)
    }
    
    private func initLayout(){
        view.backgroundColor = CommonUIAsset.commonYellow.color
        addViews()
        
        plusButton.snp.makeConstraints {
            $0.top.equalTo(200)
            $0.centerX.equalToSuperview()
        }
        
        minusButton.snp.makeConstraints {
            $0.top.equalTo(plusButton.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(minusButton.snp.bottom).offset(100)
            $0.centerX.equalToSuperview()
        }
    }
    
    func bind(reactor: HomeViewReactor){
        plusButton.rx.tap
            .map { _ in HomeViewReactor.Action.plus }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
           
        minusButton.rx.tap
            .map { _ in HomeViewReactor.Action.minus }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.count }
            .map { "\($0)" }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
