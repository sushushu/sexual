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
        titleLabel.attributedText = attributionString("欢迎使用本协议", font: titleLabelFont, color: hexColor(0x000000, alpha: 0.85), lineHeight: 28)
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
        let string = "已有\(totalCount)名用户获得保障"
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
        contentTitleLabel.attributedText = attributionString("关于《亲密行为共识确认协议》", font: contentTitleLabelFont, color: hexColor(0x000000, alpha: 0.85), lineHeight: 21)
        contentBgView.addSubview(contentTitleLabel)
        contentTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.left.right.equalToSuperview()
        }
        let contentDetailLabel = UILabel()
        let contentDetailLabelText =
        """
• 本协议是双方或多方在进行性活动前达成的行为共识

• 协议内容包括同意的范围、安全措施、隐私保护等 

• 任何一方均有权随时撤回同意 

• 协议遵循自愿、平等、真实的原则 

• 本系统生成的协议可导出为PDF保存

• 本协议不具备法律效应，仅供协议双方娱乐
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
