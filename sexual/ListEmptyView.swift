//
//  ListEmptyView.swift
//  sexual
//
//  Created by shen on 2025/4/30.
//

import UIKit

class ListEmptyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView()
        imageView.image = UIImage(named: "list_empty")
        addSubview(imageView)
        let label = UILabel()
        label.attributedText = attributionString("暂无协议", font: UIFont.systemFont(ofSize: 14, weight: .regular), color: hexColor(0x000000, alpha: 0.45), lineHeight: 20)
        addSubview(label)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(180)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
