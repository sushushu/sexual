//
//  CreateTimeCell.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import UIKit

class CreateTimeCell: UICollectionViewCell {
    
    private let leftLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let rightLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow_right")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(leftLabel)
        rightLabel.textAlignment = .right
        contentView.addSubview(rightLabel)
        contentView.addSubview(arrowImageView)
        
        leftLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        rightLabel.snp.makeConstraints { make in
            make.right.equalTo(arrowImageView.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(leftText: String, rightText: String) {
        let leftFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        let leftColor = hexColor(0x000000, alpha: 0.65)
        leftLabel.attributedText = attributionString(leftText, font: leftFont, color: leftColor, lineHeight: 14)
        
        let right = rightText.isEmpty ? "日期选择" : rightText
        let rightColor = hexColor(0x000000, alpha: 0.25)
        rightLabel.attributedText = attributionString(right, font: leftFont, color: rightColor, lineHeight: 14)
        
        if !rightText.isEmpty {
            arrowImageView.isHidden = true
            rightLabel.snp.remakeConstraints { make in
                make.right.equalToSuperview().offset(-10)
                make.centerY.equalToSuperview()
            }
        } else {
            arrowImageView.isHidden = false
            rightLabel.snp.remakeConstraints { make in
                make.right.equalTo(arrowImageView.snp.left).offset(-10)
                make.centerY.equalToSuperview()
            }
        }
    }
}
