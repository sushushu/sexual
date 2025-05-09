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
        titleLabel.attributedText = attributionString("欢迎使用亲密沟通记录", font: titleLabelFont, color: hexColor(0x000000, alpha: 0.85), lineHeight: 28)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
        }
        let countLabel = UILabel()
        countLabel.textColor = hexColor(0x3F6DF3)
        countLabel.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        
        var totalCount = UserDefaults.standard.integer(forKey: "totalCount")
        if totalCount == 0 {
            totalCount = 1428
        }
        let string = "已有\(totalCount)名用户使用此工具"
        let random = Int.random(in: 1...10)
        UserDefaults.standard.set(totalCount+random, forKey: "totalCount")
        
        let attributedString = NSMutableAttributedString(string: string)
        let range = (string as NSString).range(of: "123445")
        attributedString.addAttribute(.foregroundColor, value: appThemeColor, range: range)
        countLabel.attributedText = attributionString(attributedString, lineHeight: 28)
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
        contentTitleLabel.attributedText = attributionString("关于亲密行为沟通记录", font: contentTitleLabelFont, color: hexColor(0x000000, alpha: 0.85), lineHeight: 21)
        contentBgView.addSubview(contentTitleLabel)
        contentTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.right.equalToSuperview()
        }
        let contentDetailLabel = UILabel()
        let contentDetailLabelText =
        """
• 本记录帮助双方在亲密行为前明确沟通意愿

• 内容包括双方期望、安全措施和隐私保护等

• 任何一方均可随时改变意愿，无需解释原因

• 遵循自愿、平等、真实的原则

• 记录可导出为PDF保存作为参考

• 重要提示：此工具仅作为沟通辅助，不具备法律效力
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
        applyButton.setTitle("创建记录", for: .normal)
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
        agreementButton.setTitle("我的记录", for: .normal)
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
            title: "重要提示",
            message: "本工具仅用于辅助双方沟通意愿和边界，帮助建立相互尊重的关系。\n\n生成的内容仅为沟通参考，不具备任何法律效力，不应被视为正式文件。\n\n双方应通过持续对话确认意愿，任何人都可以随时改变意愿而无需解释。",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "我已了解", style: .default, handler: nil))
        
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
