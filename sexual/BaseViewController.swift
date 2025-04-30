//
//  BaseViewController.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bgImageView = UIImageView(frame: view.bounds)
        bgImageView.image = UIImage(named: "bg")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        
    }
}

