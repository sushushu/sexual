//
//  PlaceholderTextView.swift
//  shen
//
//  Created by 沈凯强 on 2021/01/01.
//

import UIKit

/// 可以显示占位符的 TextView
class PlaceholderTextView: UITextView {
    /// 占位 label
    private lazy var placeHolderLabel: UILabel = {
        let lb = UILabel()
        lb.font = self.font
        lb.textColor = UIColor.lightGray
        lb.frame.origin = CGPoint(x: 5, y: 8)
        lb.numberOfLines = 0
        lb.sizeToFit()
        return lb
    }()
    /// 占位文字
    var placeholder:String? {
        didSet {
            placeHolderLabel.text = placeholder
            placeHolderLabel.sizeToFit()
        }
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.font = UIFont.systemFont(ofSize: 17)
        // textView 的占位 label
        addSubview(placeHolderLabel)
        
        alwaysBounceVertical = true // 弹性滚动
        autocapitalizationType = .none // 首字母自动大写
        
        // 框架一般尽量少的使用代理,留给调用者使用,可使用通知代替
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func layoutSubviews() {
        placeHolderLabel.frame = CGRect.init(x: 5, y: 8, width: frame.width-6, height: frame.height)
        placeHolderLabel.sizeToFit()
    }
    override var font: UIFont? {
        willSet {
            placeHolderLabel.font = newValue
        }
    }
    override var textAlignment: NSTextAlignment {
        willSet {
            placeHolderLabel.textAlignment = newValue
        }
    }
    override var text: String! {
        willSet {
            placeHolderLabel.isHidden = !newValue.isEmpty
        }
    }
}
// MARK: textView 代理通知方法
private extension PlaceholderTextView {
    @objc func textDidChange(noti:Notification) {
        guard let tfview = noti.object as? UITextView, tfview == self else {
            return
        }
        placeHolderLabel.isHidden = !text.isEmpty
        //   如果没有输入内容，点击 换行 就隐藏键盘
        if text.count == 1 && text == "\n" {
            text = ""
            resignFirstResponder()
            return
        }
    }
}
