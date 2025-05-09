import UIKit

/**
 * 沟通内容编辑 Cell
 */
class CreateTemplateTextCell: UICollectionViewCell {
    
    /// 文本编辑框
    private lazy var textView: PlaceholderTextView = {
        let tv = PlaceholderTextView()
        tv.placeholder = "请输入沟通内容"
        tv.font = .systemFont(ofSize: 15)
        tv.textColor = hexColor(0x676767)
        tv.backgroundColor = .clear
        return tv
    }()
    
    /// 文本变化回调
    var textDidChangeHandler: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        // 监听文本变化
        NotificationCenter.default.addObserver(self, 
                                             selector: #selector(textDidChange), 
                                             name: UITextView.textDidChangeNotification, 
                                             object: textView)
    }
    
    /**
     * 配置 Cell
     * @param content 初始内容
     */
    func configure(content: String) {
        textView.text = content
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    /**
     * 计算文本高度
     * @param content 文本内容
     * @param limitWidth 限制宽度
     * @return 计算后的高度
     */
    class func getHeight(content: String, limitWidth: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 15)
        let height = content.labelSize(limitWidth: limitWidth - 20, font: font).height
        return height + 46 // 添加上下内边距
    }
}

// MARK: - 文本变化处理
private extension CreateTemplateTextCell {
    @objc func textDidChange() {
        textDidChangeHandler?(textView.text)
    }
} 