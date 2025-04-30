//
//  CreateTextFieldCell.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import UIKit

class CreateTextFieldCell: UICollectionViewCell {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入内容"
        textField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return textField
    }()
    private let arrowImageView = UIImageView()
    
    var textFieldDidEndEdit:((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textField.delegate = self
        contentView.addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        contentView.addSubview(arrowImageView)
        arrowImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(placeholder: String) {
        textField.placeholder = placeholder
    }
    func getText() -> String? {
        return textField.text
    }
    func setText(_ text: String?) {
        
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        let color = hexColor(0x000000, alpha: 0.65)
        textField.attributedText = attributionString(text ?? "", font: font, color: color, lineHeight: 14)
        
    }
    func setTextFieldEnabled(_ enabled: Bool) {
        textField.isEnabled = enabled
    }
    func setArrow(show:Bool, isExpand:Bool) {
        arrowImageView.isHidden = !show
        let imageName = isExpand ? "arrow_up" : "arrow_down"
        arrowImageView.image = UIImage(named: imageName)
    }
    func setTextFieldKeyboardType(type:UIKeyboardType) {
        textField.keyboardType = type
    }
}
extension CreateTextFieldCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            textFieldDidEndEdit?(text)
        }
    }
}
