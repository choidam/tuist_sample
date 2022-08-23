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

open class HomeViewController: UIViewController {
    
    // MARK: UI
    
    private let titleLabel = UILabel().then {
        $0.text = "Home VC"
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
}

extension HomeViewController {
    private func initLayout(){
        view.backgroundColor = .systemYellow
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
