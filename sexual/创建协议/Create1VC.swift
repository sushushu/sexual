//
//  Create1VC.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import UIKit

class Create1VC: BaseViewController {

    enum Section: Int, CaseIterable {
        case title
        case agreement
        case agreementConditions
        case time
        case sponsor
        case sponsorCardId
        case invitee
        case inviteeCardId
    }
    
    enum Item: Hashable {
        case title(String)
        case templateTitle(Bool)
        case templateBase
        case templateDetail
        case agreementContent(String)
        case agreementCondition(String)
        case startDate(String)
        case endDate(String)
        case sponsor(String)
        case sponsorCardId(String)
        case invitee(String)
        case inviteeCardId(String)
    }
    
    private var model = AgreementModel()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var templateIsExpanded = false
    private var startDate:Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "创建协议"
        let stepImageView = UIImageView(frame: CGRect(x: 0, y: kViewTopNaviHeight, width: view.bounds.width, height: view.bounds.width*72.0/375))
        stepImageView.image = UIImage(named: "create_step_1")
        view.addSubview(stepImageView)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        let nextButton = generalButton()
        nextButton.setTitle("下一步", for: .normal)
        nextButton.isEnabled = false
        view.addSubview(nextButton)
        weak var weakself = self
        nextButton.addAction(UIAction(handler: { _ in
            guard let model = weakself?.model else {
                return
            }
            let vc = Create2VC(model: model)
            weakself?.navigationController?.pushViewController(vc, animated: true)
        }), for: .touchUpInside)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(stepImageView.snp.bottom)
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
        // 创建 DateFormatter 实例
        let dateFormatter = DateFormatter()
        // 示例 1: 转换为 "yyyy-MM-dd" 格式的字符串
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        model.createDate = dateString
        
        initDatasource()
        updateDatasource()
        
        NotificationCenter.default.addObserver(forName: modelValueChangeNotification, object: nil, queue: .main) { _ in
            DispatchQueue.global().async {
                guard let self = weakself else { return }
                if self.model.content.isEmpty || self.model.startDate.isEmpty || self.model.endDate.isEmpty || self.model.sponsor.isEmpty || self.model.invitee.isEmpty {
                    DispatchQueue.main.async {
                        nextButton.isEnabled = false
                    }
                    return
                }
                DispatchQueue.main.async {
                    nextButton.isEnabled = true
                }
            }
        }
    }
    func updateDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([.title(model.title)], toSection: .title)
        if model.content.isEmpty {
            snapshot.deleteSections([.agreementConditions])
            snapshot.appendItems([.templateTitle(templateIsExpanded)], toSection: .agreement)
            if templateIsExpanded {
                snapshot.appendItems([.templateBase, .templateDetail], toSection: .agreement)
            }
        } else {
            snapshot.appendItems([.agreementContent(model.content)], toSection: .agreement)
            let items = model.conditions.map { Item.agreementCondition($0) }
            if items.isEmpty {
                snapshot.deleteSections([.agreementConditions])
            } else {
                snapshot.appendItems(items, toSection: .agreementConditions)
            }
        }
        snapshot.appendItems([.startDate(model.startDate), .endDate(model.endDate)], toSection: .time)
        snapshot.appendItems([.sponsor(model.sponsor)], toSection: .sponsor)
        snapshot.appendItems([.sponsorCardId(model.sponsorCardId)], toSection: .sponsorCardId)
        snapshot.appendItems([.invitee(model.invitee)], toSection: .invitee)
        snapshot.appendItems([.inviteeCardId(model.inviteeCardId)], toSection: .inviteeCardId)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func initDatasource() {
        weak var weakself = self
        let textFieldCellRegistration = UICollectionView.CellRegistration<CreateTextFieldCell, Item> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            cell.setTextFieldEnabled(true)
            cell.setArrow(show: false, isExpand: false)
            cell.setTextFieldKeyboardType(type: .default)
            switch itemIdentifier {
            case .title(let title):
                cell.setTextFieldEnabled(false)
                cell.setText(title)
            case .templateTitle(let isSpread):
                cell.setArrow(show: true, isExpand: isSpread)
                cell.setTextFieldEnabled(false)
                cell.setText("选择协议内容模板")
            case .sponsor(let text):
                cell.setText(text)
                cell.configure(placeholder: "请输入发起人姓名")
                cell.textFieldDidEndEdit = { text in
                    weakself?.model.sponsor = text
                    weakself?.updateDatasource()
                }
            case .sponsorCardId(let text):
                cell.setText(text)
                cell.configure(placeholder: "请输入发起人身份证号")
                cell.setTextFieldKeyboardType(type: .numberPad)
                cell.textFieldDidEndEdit = { text in
                    weakself?.model.sponsorCardId = text
                    weakself?.updateDatasource()
                }
            case .invitee(let text):
                cell.setText(text)
                cell.configure(placeholder: "请输入受邀人姓名")
                cell.textFieldDidEndEdit = { text in
                    weakself?.model.invitee = text
                    weakself?.updateDatasource()
                }
            case .inviteeCardId(let text):
                cell.setText(text)
                cell.configure(placeholder: "请输入受邀人身份证号")
                cell.setTextFieldKeyboardType(type: .numberPad)
                cell.textFieldDidEndEdit = { text in
                    weakself?.model.inviteeCardId = text
                    weakself?.updateDatasource()
                }
            default:
                break
            }
        }
        let templateCellRegistration = UICollectionView.CellRegistration<CreateTemplateCell, Item> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            switch itemIdentifier {
            case .templateBase:
                cell.configure(title: "基础同意协议", detail: "最基本的协议，包含必要的同意表述和安全措施")
                cell.buttonAction = {
                    let vc = CreateTemplateVC(type: .base)
                    weakself?.navigationController?.pushViewController(vc, animated: true)
                    vc.confirmClsoure = { templateModel in
                        weakself?.model.content = templateModel.content
                        weakself?.model.conditions = templateModel.conditions
                        weakself?.updateDatasource()
                    }
                }
            case .templateDetail:
                cell.configure(title: "详细同意协议", detail: "更详细的协议，包含具体行为边界和个人偏好")
                cell.buttonAction = {
                    let vc = CreateTemplateVC(type: .detail)
                    weakself?.navigationController?.pushViewController(vc, animated: true)
                    vc.confirmClsoure = { templateModel in
                        weakself?.model.content = templateModel.content
                        weakself?.model.conditions = templateModel.conditions
                        weakself?.updateDatasource()
                    }
                }
            default:
                break
            }
        }
        let agreementContentCellRegistration = UICollectionView.CellRegistration<CreateTextCell, String> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            cell.configure(content: itemIdentifier)
        }
        let selectCellRegistration = UICollectionView.CellRegistration<CreateTemplate1ConditionCell, String> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            let text = "\(indexPath.item+1). \(itemIdentifier)"
            cell.configure(condition: text, isSelected: true)
        }
        let timeCellRegistration = UICollectionView.CellRegistration<CreateTimeCell, Item> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            switch itemIdentifier {
            case .startDate(let text):
                cell.configure(leftText: "开始时间", rightText: text)
            case .endDate(let text):
                cell.configure(leftText: "结束时间", rightText: text)
            default:
                break
            }
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .templateBase, .templateDetail:
                return collectionView.dequeueConfiguredReusableCell(using: templateCellRegistration, for: indexPath, item: itemIdentifier)
            case .startDate, .endDate:
                return collectionView.dequeueConfiguredReusableCell(using: timeCellRegistration, for: indexPath, item: itemIdentifier)
            case .agreementContent(let content):
                return collectionView.dequeueConfiguredReusableCell(using: agreementContentCellRegistration, for: indexPath, item: content)
            case .agreementCondition(let condition):
                return collectionView.dequeueConfiguredReusableCell(using: selectCellRegistration, for: indexPath, item: condition)
            default:
                return collectionView.dequeueConfiguredReusableCell(using: textFieldCellRegistration, for: indexPath, item: itemIdentifier)
            }
        })
        let headerViewRegistration = UICollectionView.SupplementaryRegistration<CreateSectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { (headerView, String, indexPath) in
            guard let section = weakself?.dataSource.sectionIdentifier(for: indexPath.section) else {
                return
            }
            switch section {
            case .title:
                headerView.configure(isRequired: true, title: "协议标题", tips: "")
            case .agreement:
                headerView.configure(isRequired: true, title: "协议内容", tips: "")
            case .agreementConditions:
                headerView.configure(isRequired: false, title: "安全措施", tips: "")
            case .time:
                headerView.configure(isRequired: true, title: "约定时间", tips: "")
            case .sponsor:
                headerView.configure(isRequired: true, title: "发起方", tips: "")
            case .sponsorCardId:
                headerView.configure(isRequired: false, title: "身份账号", tips: "(选填)")
            case .invitee:
                headerView.configure(isRequired: true, title: "被邀请方", tips: "")
            case .inviteeCardId:
                headerView.configure(isRequired: false, title: "身份证号", tips: "(选填)")
            }
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerViewRegistration, for: indexPath)
        }
    }
}

extension Create1VC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return CGSize.zero
        }
        let width = collectionView.bounds.width-40
        switch item {
        case .templateBase, .templateDetail:
            return CGSize(width:width, height: 120)
        case .agreementContent(let text):
            let height = CreateTextCell.getHeight(content: text, limitWidth: width)
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: width, height: 40)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        switch item {
           case .templateTitle(_):
                templateIsExpanded.toggle()
                updateDatasource()
        case .startDate(_):
            let datePicker = CreateDatePickerView(miniDate: Date(), maxDate: nil)
            datePicker.show()
            weak var weakself = self
            datePicker.confirmClosure = { date in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
                weakself?.model.startDate = formatter.string(from: date)
                weakself?.updateDatasource()
                weakself?.startDate = date
            }
        case .endDate(_):
            guard let startDate else { return }
            guard let maxDate = getTimeAfter24Hours(from: startDate) else { return }
            let datePicker = CreateDatePickerView(miniDate: startDate, maxDate: maxDate)
            datePicker.show()
            weak var weakself = self
            datePicker.confirmClosure = { date in
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy年MM月dd日 HH:mm"
                weakself?.model.endDate = formatter.string(from: date)
                weakself?.updateDatasource()
            }
        default:
            break
        }
    }
    
    // 定义一个函数，用于获取指定日期 24 小时后的时间
    func getTimeAfter24Hours(from date: Date) -> Date? {
        let calendar = Calendar.current
        // 创建一个时间间隔为 24 小时的时间间隔
        let oneDay: TimeInterval = 24 * 60 * 60
        // 使用 calendar 的 date(byAdding:value:to:) 方法获取 24 小时后的时间
        return calendar.date(byAdding:.second, value: Int(oneDay), to: date)
    }

}
