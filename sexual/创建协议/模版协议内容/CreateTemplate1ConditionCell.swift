//
//  CreateTemplate1ConditionCell.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class CreateTemplate1ConditionCell: UICollectionViewCell {
    
    private let conditionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    private let selectedImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(conditionLabel)
        conditionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        selectedImageView.image = UIImage(named: "selected")
        contentView.addSubview(selectedImageView)
        selectedImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(condition: String, isSelected: Bool) {
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        conditionLabel.attributedText = attributionString(condition, font: font, color: hexColor(000000, alpha: 0.65), lineHeight: 14)
        let imageName = isSelected ? "condition_select" : "condition_unselect"
        selectedImageView.image = UIImage(named: imageName)
    }
}
