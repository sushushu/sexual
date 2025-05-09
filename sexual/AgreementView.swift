//
//  AgreementView.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class AgreementView: UIView {
    private let verticalSpacing:CGFloat = 20
    private let horizontalSpacing:CGFloat = 20
    
    
    func setupUI(model:AgreementModel, isSign: Bool) {
        // 添加免责声明在顶部
        let disclaimerLabel = UILabel()
        disclaimerLabel.attributedText = getDisclaimerAttributedString(text: "此记录仅代表沟通时的意愿，可能随实际情况变化。不具备任何法律效力，仅用于促进双方沟通。")
        disclaimerLabel.numberOfLines = 0
        disclaimerLabel.textAlignment = .center
        disclaimerLabel.backgroundColor = hexColor(0xFFECEC)
        disclaimerLabel.layer.cornerRadius = 5
        disclaimerLabel.layer.masksToBounds = true
        addSubview(disclaimerLabel)
        disclaimerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(verticalSpacing/2)
            make.left.right.equalToSuperview().inset(horizontalSpacing/2)
        }
        
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        addSubview(titleLabel)
        titleLabel.text = model.title
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(disclaimerLabel.snp.bottom).offset(verticalSpacing)
            make.left.right.equalToSuperview().inset(horizontalSpacing)
        }
        
        let createTitleLabel = UILabel()
        createTitleLabel.attributedText = getTtitleAttributedString(text: "创建日期")
        addSubview(createTitleLabel)
        let createDateLabel = UILabel()
        createDateLabel.attributedText = getDetailAttributedString(text: model.createDate)
        addSubview(createDateLabel)
        createTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        createDateLabel.snp.makeConstraints { make in
            make.top.equalTo(createTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        
        let sponsorLabel1 = UILabel()
        sponsorLabel1.attributedText = getTtitleAttributedString(text: "发起方:")
        addSubview(sponsorLabel1)
        let sponsorLabel2 = UILabel()
        sponsorLabel2.attributedText = getDetailAttributedString(text: model.sponsor)
        addSubview(sponsorLabel2)
        let sponsorLabel3 = UILabel()
        sponsorLabel3.attributedText = getTtitleAttributedString(text: "身份证号:")
        addSubview(sponsorLabel3)
        let sponsorLabel4 = UILabel()
        sponsorLabel4.attributedText = getDetailAttributedString(text: model.sponsorCardId)
        addSubview(sponsorLabel4)
        sponsorLabel1.snp.makeConstraints { make in
            make.top.equalTo(createDateLabel.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        sponsorLabel2.snp.makeConstraints { make in
            make.left.equalTo(sponsorLabel1.snp.right).offset(10)
            make.centerY.equalTo(sponsorLabel1)
        }
        sponsorLabel3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(horizontalSpacing+150)
            make.centerY.equalTo(sponsorLabel1)
        }
        sponsorLabel4.snp.makeConstraints { make in
            make.left.equalTo(sponsorLabel3.snp.right).offset(10)
            make.centerY.equalTo(sponsorLabel1)
        }
        
        let inviteeLabel1 = UILabel()
        inviteeLabel1.attributedText = getTtitleAttributedString(text: "受邀方:")
        addSubview(inviteeLabel1)
        let inviteeLabel2 = UILabel()
        inviteeLabel2.attributedText = getDetailAttributedString(text: model.invitee)
        addSubview(inviteeLabel2)
        let inviteeLabel3 = UILabel()
        inviteeLabel3.attributedText = getTtitleAttributedString(text: "身份证号:")
        addSubview(inviteeLabel3)
        let inviteeLabel4 = UILabel()
        inviteeLabel4.attributedText = getDetailAttributedString(text: model.inviteeCardId)
        addSubview(inviteeLabel4)
        inviteeLabel1.snp.makeConstraints { make in
            make.top.equalTo(sponsorLabel1.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        inviteeLabel2.snp.makeConstraints { make in
            make.left.equalTo(inviteeLabel1.snp.right).offset(10)
            make.centerY.equalTo(inviteeLabel1)
        }
        inviteeLabel3.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(horizontalSpacing+150)
            make.centerY.equalTo(inviteeLabel1)
        }
        inviteeLabel4.snp.makeConstraints { make in
            make.left.equalTo(inviteeLabel3.snp.right).offset(10)
            make.centerY.equalTo(inviteeLabel1)
        }
        
        let contentTitleLabel = UILabel()
        contentTitleLabel.attributedText = getTtitleAttributedString(text: "沟通内容")
        addSubview(contentTitleLabel)
        let contentLabel = UILabel()
        contentLabel.attributedText = getDetailAttributedString(text: model.content)
        contentLabel.numberOfLines = 0
        addSubview(contentLabel)
        contentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(inviteeLabel1.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(contentTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(horizontalSpacing)
        }
        
        var conditionLabel:UILabel?
        if !model.conditions.isEmpty {
            let conditionTitleLabel = UILabel()
            conditionTitleLabel.attributedText = getTtitleAttributedString(text: "安全措施")
            addSubview(conditionTitleLabel)
            conditionTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(contentLabel.snp.bottom).offset(verticalSpacing)
                make.left.equalToSuperview().offset(horizontalSpacing)
            }
            for condition in model.conditions {
                let lab = UILabel()
                lab.attributedText = getDetailAttributedString(text: "・\(condition)")
                addSubview(lab)
                if let label = conditionLabel {
                    lab.snp.makeConstraints { make in
                        make.left.equalToSuperview().offset(horizontalSpacing)
                        make.top.equalTo(label.snp.bottom)
                    }
                } else {
                    lab.snp.makeConstraints { make in
                        make.left.equalToSuperview().offset(horizontalSpacing)
                        make.top.equalTo(conditionTitleLabel.snp.bottom)
                    }
                }
                conditionLabel = lab
            }
        }
        
        let ccLabel = conditionLabel ?? contentLabel
        let timeTitleLabel = UILabel()
        timeTitleLabel.attributedText = getTtitleAttributedString(text: "沟通时间")
        addSubview(timeTitleLabel)
        let timeLabel = UILabel()
        timeLabel.attributedText = getDetailAttributedString(text: "\(model.startDate)-\(model.endDate)")
        addSubview(timeLabel)
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(ccLabel.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeTitleLabel.snp.bottom)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        
        let privacyTitleLabel = UILabel()
        privacyTitleLabel.attributedText = getTtitleAttributedString(text: "隐私说明")
        addSubview(privacyTitleLabel)
        let privacyLabel = UILabel()
        privacyLabel.attributedText = getDetailAttributedString(text: model.privacy)
        privacyLabel.numberOfLines = 0
        addSubview(privacyLabel)
        privacyTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        privacyLabel.snp.makeConstraints { make in
            make.top.equalTo(privacyTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(horizontalSpacing)
        }
        
        let regretTitleLabel = UILabel()
        regretTitleLabel.attributedText = getTtitleAttributedString(text: "意愿变更说明")
        addSubview(regretTitleLabel)
        let regreLabel = UILabel()
        regreLabel.attributedText = getDetailAttributedString(text: model.regret)
        regreLabel.numberOfLines = 0
        addSubview(regreLabel)
        regretTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(privacyLabel.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        regreLabel.snp.makeConstraints { make in
            make.top.equalTo(regretTitleLabel.snp.bottom)
            make.left.right.equalToSuperview().inset(horizontalSpacing)
        }
        
        let additonalTitleLabel = UILabel()
        additonalTitleLabel.attributedText = getTtitleAttributedString(text: "补充说明")
        addSubview(additonalTitleLabel)
        let additonalLabel = UILabel()
        additonalLabel.attributedText = getDetailAttributedString(text: model.additional.isEmpty ? "无" : model.additional)
        additonalLabel.numberOfLines = 0
        addSubview(additonalLabel)
        additonalTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(regreLabel.snp.bottom).offset(verticalSpacing)
            make.left.equalToSuperview().offset(horizontalSpacing)
        }
        if !isSign {
            additonalLabel.snp.makeConstraints { make in
                make.top.equalTo(additonalTitleLabel.snp.bottom)
                make.left.right.equalToSuperview().inset(horizontalSpacing)
                make.bottom.equalToSuperview().offset(-verticalSpacing)
            }
        } else {
            additonalLabel.snp.makeConstraints { make in
                make.top.equalTo(additonalTitleLabel.snp.bottom)
                make.left.right.equalToSuperview().inset(horizontalSpacing)
            }
            let tipsTitleLabel = UILabel()
            tipsTitleLabel.attributedText = getTtitleAttributedString(text: "特别提示")
            addSubview(tipsTitleLabel)
            let tipsDetailLabel = UILabel()
            tipsDetailLabel.attributedText = getDetailAttributedString(text: "本记录仅用于促进双方沟通和相互理解，不具备任何法律效力。双方可随时重新沟通并更新意愿。")
            tipsDetailLabel.numberOfLines = 0
            addSubview(tipsDetailLabel)
            tipsTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(additonalLabel.snp.bottom).offset(verticalSpacing)
                make.left.equalToSuperview().offset(horizontalSpacing)
            }
            tipsDetailLabel.snp.makeConstraints { make in
                make.top.equalTo(tipsTitleLabel.snp.bottom)
                make.left.right.equalToSuperview().inset(horizontalSpacing)
            }
            
            // 时间戳信息，而非签名
            let timestampTitleLabel = UILabel()
            timestampTitleLabel.attributedText = getTtitleAttributedString(text: "记录生成时间")
            addSubview(timestampTitleLabel)
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
            let currentDateString = formatter.string(from: Date())
            
            let timestampLabel = UILabel()
            timestampLabel.attributedText = getDetailAttributedString(text: currentDateString)
            addSubview(timestampLabel)
            
            timestampTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(tipsDetailLabel.snp.bottom).offset(verticalSpacing)
                make.left.equalToSuperview().offset(horizontalSpacing)
            }
            timestampLabel.snp.makeConstraints { make in
                make.top.equalTo(timestampTitleLabel.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(horizontalSpacing)
                make.bottom.equalToSuperview().inset(verticalSpacing)
            }
        }
    }
    
    private func getTtitleAttributedString(text:String) -> NSAttributedString {
        let titleFont = UIFont.systemFont(ofSize: 14, weight: .medium)
        return attributionString(text, font: titleFont, color: hexColor(000000, alpha: 0.85), lineHeight: 20)
    }
    
    private func getDetailAttributedString(text:String) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return attributionString(text, font: font, color: hexColor(000000, alpha: 0.65), lineHeight: 20)
    }
    
    private func getDisclaimerAttributedString(text:String) -> NSAttributedString {
        let font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return attributionString(text, font: font, color: hexColor(0xFF0000, alpha: 0.85), lineHeight: 18)
    }
}
