//
//  MineAgreementListCell.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class MineAgreementListCell: UICollectionViewCell {
    
    private var sponsorLabel = UILabel()
    private var inviteeLabel = UILabel()
    private var timeLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let wrapView = UIView()
        wrapView.layer.cornerRadius = 10
        wrapView.layer.borderWidth = 1
        wrapView.layer.borderColor = hexColor(0xE9E9EA).cgColor
        contentView.addSubview(wrapView)
        
        wrapView.addSubview(sponsorLabel)
        inviteeLabel.textAlignment = .right
        wrapView.addSubview(inviteeLabel)
        let lineView = UIView()
        lineView.backgroundColor = hexColor(000000, alpha: 0.08)
        wrapView.addSubview(lineView)
        wrapView.addSubview(timeLabel)
        
        wrapView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        sponsorLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
        }
        inviteeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.height.top.equalTo(sponsorLabel)
        }
        lineView.snp.makeConstraints { make in
            make.left.equalTo(sponsorLabel)
            make.right.equalTo(inviteeLabel)
            make.height.equalTo(1)
            make.top.equalTo(sponsorLabel.snp.bottom).offset(20)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(20)
            make.left.equalTo(sponsorLabel)
            make.height.equalTo(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(sponsor:String, invitee:String, time:String) {
        let font = UIFont.systemFont(ofSize: 13, weight: .medium)
        let textColor = hexColor(000000, alpha: 0.85)
        sponsorLabel.attributedText = attributionString("发起方:\(sponsor)", font: font, color: textColor, lineHeight: 13)
        inviteeLabel.attributedText = attributionString("被邀请方:\(invitee)", font: font, color: textColor, lineHeight: 13)
        timeLabel.attributedText = attributionString("生成时间:\(time)", font: UIFont.systemFont(ofSize: 12, weight: .regular), color: hexColor(000000, alpha: 0.65), lineHeight: 18)
    }
}
