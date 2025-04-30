//
//  RootNavigationController.swift
//  zlps
//
//  Created by shen on 2025/4/9.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        // 修改返回按钮文字样式
        appearance.backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.clear
        ]
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil
        // 标准模式下的外观表现
        navigationBar.standardAppearance = appearance
        // 在滚动到边缘（通常是顶部）时的外观表现
        navigationBar.scrollEdgeAppearance = appearance
        // 在紧凑显示模式下的外观
        navigationBar.compactAppearance = appearance
        
        navigationBar.tintColor = .black
    }
}
