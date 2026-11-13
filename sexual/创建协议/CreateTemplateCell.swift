//
//  CreateTemplateCell.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import UIKit

class CreateTemplateCell: UICollectionViewCell {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.setTitle("使用该模板", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = appThemeColor
        button.layer.cornerRadius = 5
        return button
    }()

    var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        weak var weakself = self
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.addAction(UIAction(handler: { _ in
            weakself?.buttonAction?()
        }), for: .touchUpInside)
        contentView.addSubview(button)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
        }
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(110)
            make.height.equalTo(32)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title:String, detail:String) {
        titleLabel.attributedText = attributionString(title, font: UIFont.systemFont(ofSize: 14, weight: .medium), color: hexColor(0x000000, alpha: 0.85), lineHeight: 14)
        detailLabel.attributedText = attributionString(detail, font: UIFont.systemFont(ofSize: 14, weight: .regular), color: hexColor(0x000000, alpha: 0.65), lineHeight: 20)
    }
    
}
