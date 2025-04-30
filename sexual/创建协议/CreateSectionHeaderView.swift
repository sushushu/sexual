//
//  CreateSectionHeaderView.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class CreateSectionHeaderView: UICollectionReusableView {
    
    private let label = UILabel()
    private let tipsLabel = UILabel()
    private let asteriskLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let logoView = UIView()
        logoView.backgroundColor = appThemeColor
        addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(2)
            make.height.equalTo(20)
        }
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(logoView.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }

        asteriskLabel.text = "*"
        asteriskLabel.textColor = appThemeColor
        addSubview(asteriskLabel)
        asteriskLabel.snp.makeConstraints { make in
            make.left.equalTo(label.snp.right)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        addSubview(tipsLabel)
        tipsLabel.snp.makeConstraints { make in
            make.left.equalTo(asteriskLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(isRequired:Bool, title: String, tips: String) {
        asteriskLabel.isHidden = !isRequired
        let titleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.attributedText = attributionString(title, font: titleFont, color: hexColor(000000, alpha: 0.85), lineHeight: 20)
        
        let tipsFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        tipsLabel.attributedText = attributionString(tips, font: tipsFont, color: hexColor(0x000000, alpha: 0.45), lineHeight: 20)
    }
}
