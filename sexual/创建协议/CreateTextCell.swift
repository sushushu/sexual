//
//  CreateTextCell.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class CreateTextCell: UICollectionViewCell {

    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(content: String) {
        contentLabel.attributedText = CreateTextCell.getAttributeText(content: content)
    }
    
    private class func getAttributeText(content: String) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return attributionString(content, font: font, color: hexColor(000000, alpha: 0.65), lineHeight: 20)
    }
    class func getHeight(content: String, limitWidth:CGFloat) -> CGFloat {
        let height = getAttributeText(content: content).labelSize(limitWidth: limitWidth-10).height
        return height + 10
    }
}
