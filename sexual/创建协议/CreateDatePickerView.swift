//
//  CreateDatePickerView.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class CreateDatePickerView: UIView {
    
    private var ovc:OverlayController?
    private var cancelButton = UIButton(type: .custom)
    private var confirmButton = UIButton(type: .custom)
    private var titleLabel = UILabel()
    private var datePicker = UIDatePicker()
    
    var confirmClosure:((_ date:Date)->Void)?
    
    convenience init(miniDate:Date?, maxDate:Date?) {
        self.init(frame: .zero)
        self.datePicker.minimumDate = miniDate
        self.datePicker.maximumDate = maxDate
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        clipsToBounds = true
        backgroundColor = .white
        
        let buttonFont = UIFont.systemFont(ofSize: 14, weight: .regular)
        let buttonNormalColor = hexColor(0x969799)
        
        cancelButton.setAttributedTitle(attributionString("取消", font: buttonFont, color: buttonNormalColor, lineHeight: 20), for: .normal)
        addSubview(cancelButton)
        confirmButton.setAttributedTitle(attributionString("确定", font: buttonFont, color: appThemeColor, lineHeight: 20), for: .normal)
        addSubview(confirmButton)
        titleLabel.attributedText = attributionString("选择日期时间", font: UIFont.systemFont(ofSize: 16, weight: .medium), color: hexColor(0x323233), lineHeight: 22)
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        
        datePicker.minuteInterval = 5
        datePicker.locale = Locale(identifier: "zh")
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .wheels
        addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(50)
            make.bottom.equalTo(datePicker.snp.top).offset(-20)
        }
        confirmButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(50)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(cancelButton.snp.right)
            make.right.equalTo(confirmButton.snp.left)
            make.centerY.equalTo(cancelButton)
        }
        
        weak var weakself = self
        cancelButton.addAction(UIAction(handler: { _ in
            weakself?.ovc?.dissmiss()
        }), for: .touchUpInside)
        
        confirmButton.addAction(UIAction(handler: { action in
            guard let self = weakself else { return }
            weakself?.confirmClosure?(self.datePicker.date)
            weakself?.ovc?.dissmiss()
        }), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show() {
        ovc = OverlayController(view: self)
        ovc?.maskStyle = .black(opacity: 0.4)
        ovc?.layoutPosition = .bottom
        ovc?.presentationStyle = .fade
        ovc?.present()
        ovc?.isDismissOnMaskTouched = true
        
        self.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }
    }

}
