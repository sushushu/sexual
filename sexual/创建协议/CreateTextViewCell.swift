//
//  CreateTextViewCell.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class CreateTextViewCell: UICollectionViewCell {
    private let textView: PlaceholderTextView = {
        let textView = PlaceholderTextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.textColor = hexColor(000000, alpha: 0.65)
        textView.placeholder = "请输入其他条款"
        return textView
    }()
    var textViewDidEndEdit:((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textView.delegate = self
        contentView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        textView.text = CreateTextViewCell.getAttributeText(text: text).string
    }
    
    private class func getAttributeText(text: String) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return attributionString(text, font: font, color: hexColor(000000, alpha: 0.65), lineHeight: 20)
    }
    class func getHeight(text: String, limitWidth:CGFloat) -> CGFloat {
        let height = getAttributeText(text: text).labelSize(limitWidth: limitWidth-10).height
        return height + 10
    }
}

extension CreateTextViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        if let text = textView.text {
            textViewDidEndEdit?(text)
        }
    }
}
