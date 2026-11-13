//
//  ListEmptyView.swift
//  sexual
//
//  Created by shen on 2025/4/30.
//

import UIKit

class ListEmptyView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "list_empty")
        return imageView
    }()
    
    private lazy var tipLabel: UILabel = {
        let label = UILabel()
        label.attributedText = attributionString("暂无协议", font: UIFont.systemFont(ofSize: 14, weight: .regular), color: hexColor(0x000000, alpha: 0.45), lineHeight: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        addSubview(tipLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(108)
        }
        
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
