//
//  HomeVC.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import UIKit

class HomeVC: BaseViewController {
    
    private let leftSpace:CGFloat = 30
    private let bottomViewHeight:CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(-bottomViewHeight)
        }
        let contentView = UIView()
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalTo(view)
        }
        
        let titleLabel = UILabel()
        let titleLabelFont = UIFont.systemFont(ofSize: 30, weight: .medium)
        titleLabel.attributedText = attributionString("欢迎使用性同意协议", font: titleLabelFont, color: hexColor(0x000000, alpha: 0.85), lineHeight: 28)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
        }
        let countLabel = UILabel()
        countLabel.textColor = hexColor(0x3F6DF3)
        countLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        countLabel.attributedText = attributionString("尊重意愿，随时可以撤回同意", font: countLabel.font, color: appThemeColor, lineHeight: 28)
        contentView.addSubview(countLabel)
        countLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        let contentBgView = UIView()
        contentView.addSubview(contentBgView)
        contentBgView.backgroundColor = .white
        contentBgView.snp.makeConstraints { make in
            make.top.equalTo(countLabel.snp.bottom).offset(20)
            make.left.equalTo(leftSpace)
            make.right.equalTo(-leftSpace)
            
        }
        let contentTitleLabel = UILabel()
        let contentTitleLabelFont = UIFont.systemFont(ofSize: 15, weight: .medium)
        contentTitleLabel.attributedText = attributionString("关于性同意协议", font: contentTitleLabelFont, color: hexColor(0x000000, alpha: 0.85), lineHeight: 21)
        contentBgView.addSubview(contentTitleLabel)
        contentTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.right.equalToSuperview()
        }
        let contentDetailLabel = UILabel()
        let contentDetailLabelText =
        """
• 性同意协议记录双方对亲密行为的意愿

• 内容包括同意的范围、安全措施和隐私保护

• 任何一方均有权随时撤回同意

• 双方应遵循自愿、平等、真实的原则

• 协议可导出为 PDF 保存
"""
        let contentDetailLabelFont = UIFont.systemFont(ofSize: 13, weight: .regular)
        contentDetailLabel.attributedText = attributionString(contentDetailLabelText, font: contentDetailLabelFont, color: hexColor(0x000000, alpha: 0.65), lineHeight: 18)
        contentDetailLabel.numberOfLines = 0
        contentBgView.addSubview(contentDetailLabel)
        contentDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
        }
        
        let bottomView = UIView()
        bottomView.backgroundColor = .white
        view.addSubview(bottomView)
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(bottomViewHeight)
        }
        let applyButton = UIButton(type: .custom)
        applyButton.setTitle("发起申请", for: .normal)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        applyButton.layer.cornerRadius = 10
        applyButton.backgroundColor = appThemeColor
        applyButton.addTarget(self, action: #selector(applyButtonClicked), for: .touchUpInside)
        bottomView.addSubview(applyButton)
        applyButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0)
            make.height.equalTo(50)
        }
        let agreementButton = UIButton(type: .custom)
        agreementButton.setTitle("我的协议", for: .normal)
        agreementButton.setTitleColor(appThemeColor, for: .normal)
        agreementButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        agreementButton.layer.cornerRadius = 10
        agreementButton.layer.borderWidth = 1
        agreementButton.layer.borderColor = appThemeColor.cgColor
        agreementButton.addTarget(self, action: #selector(agreementButtonClicked), for: .touchUpInside)
        bottomView.addSubview(agreementButton)
        agreementButton.snp.makeConstraints { make in
            make.top.equalTo(applyButton.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().dividedBy(3.0)
            make.height.equalTo(50)
        }
        
        // 显示免责声明弹窗，如果用户第一次使用
        if UserDefaults.standard.bool(forKey: "hasShownDisclaimer") == false {
            showDisclaimerAlert()
            UserDefaults.standard.set(true, forKey: "hasShownDisclaimer")
        }
    }
    
    /// 显示免责声明弹窗
    private func showDisclaimerAlert() {
        let alert = UIAlertController(
            title: "重要声明",
            message: "本应用是一个沟通辅助工具，不是法律文件生成器。\n\n本工具仅用于帮助双方更好地沟通和了解彼此的想法，生成的任何内容都不具备法律约束力。\n\n真正的同意只能通过当面的、持续的沟通来确认，任何书面记录都无法替代实时的沟通与确认。\n\n请将此工具视为沟通的起点，而非终点。",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "我明白这只是沟通工具", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    @objc func applyButtonClicked() {
        let vc = Create1VC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func agreementButtonClicked() {
        let vc = MineAgreementListVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
