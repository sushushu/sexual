import UIKit

class MineAgreementListCell: UICollectionViewCell {
    private let sponsorLabel = UILabel()
    private let inviteeLabel = UILabel()
    private let timeLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear

        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 14
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor(white: 0.91, alpha: 1).cgColor
        contentView.addSubview(card)
        card.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        let marker = UIView()
        marker.backgroundColor = appThemeColor
        marker.layer.cornerRadius = 2
        card.addSubview(marker)
        marker.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(18)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(4)
            make.height.equalTo(18)
        }

        let arrow = UIImageView(image: UIImage(systemName: "chevron.right"))
        arrow.tintColor = UIColor(white: 0.72, alpha: 1)
        arrow.contentMode = .scaleAspectFit
        card.addSubview(arrow)
        arrow.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-18)
            make.centerY.equalToSuperview()
            make.width.equalTo(10)
            make.height.equalTo(16)
        }

        let names = UIStackView(arrangedSubviews: [sponsorLabel, inviteeLabel])
        names.axis = .vertical
        names.spacing = 8
        card.addSubview(names)
        names.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalTo(marker.snp.right).offset(12)
            make.right.equalTo(arrow.snp.left).offset(-16)
        }
        for label in [sponsorLabel, inviteeLabel] {
            label.numberOfLines = 0
            label.font = .systemFont(ofSize: 15, weight: .medium)
            label.textColor = UIColor(white: 0.16, alpha: 1)
        }

        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = UIColor(white: 0.48, alpha: 1)
        timeLabel.numberOfLines = 0
        card.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(names.snp.bottom).offset(14)
            make.left.right.equalTo(names)
            make.bottom.equalToSuperview().offset(-18)
        }
        isAccessibilityElement = true
        accessibilityTraits = .button
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(sponsor: String, invitee: String, time: String) {
        sponsorLabel.text = "发起方  \(sponsor)"
        inviteeLabel.text = "被邀请方  \(invitee)"
        timeLabel.text = "生成时间  \(time)"
        accessibilityLabel = "发起方：\(sponsor)，被邀请方：\(invitee)，生成时间：\(time)"
        accessibilityHint = "查看协议详情"
    }
}
