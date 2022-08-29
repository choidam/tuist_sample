//
//  HomeViewController.swift
//  Home
//
//  Created by choidam on 2022/08/23.
//  Copyright © 2022 cocaine.io. All rights reserved.
//

import CommonUI

import UIKit
import SnapKit
import Then
import RxSwift

open class HomeViewController: UIViewController {
    
    // MARK: UI
    
    private let titleLabel = UILabel().then {
        $0.text = "Home VC"
        $0.font = CommonUIFontFamily.Pretendard.bold.font(size: 15)
    }
    
    // MARK: Property
    
    private let reactor: HomeViewReactor
    
    var disposeBag = DisposeBag()
    
    init(reactor: HomeViewReactor) {
        self.reactor = reactor
        super.init(nibName: nil, bundle: nil)
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
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
