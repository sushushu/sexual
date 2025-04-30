//
//  CreateTemplateVC.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class CreateTemplateVC: BaseViewController {
    enum TemplateType {
        case base
        case detail
        
        var text:String {
            switch self {
            case .base:
                return "我们双方在完全自愿、理性和清醒的状态下，同意进行亲密行为。我们确认彼此已经达到法定成年年龄，并且对可能发生的行为有充分理解。我们承诺相互尊重对方的边界和意愿，任何一方都有权随时终止行为而无需解释原因。"
            case .detail:
                return "我们双方在完全自愿、理性和清醒的状态下，同意进行亲密行为。我们确认彼此已经达到法定成年年龄，并且对可能发生的行为有充分理解。我们已经讨论并同意了可接受的互动范围，包括但不限于哪些行为是可以的，哪些是不可接受的。我们将在整个过程中保持沟通，并尊重彼此设定的边界。我们理解，即使之前同意了某种行为，任何一方在任何时候都有权改变主意。"
            }
        }
    }
    private var conditions: [CreateTemplateConditionModel] = [
        CreateTemplateConditionModel(text: "使用避孕措施", isSelected: false),
        CreateTemplateConditionModel(text: "性传播疾病检测", isSelected: false),
        CreateTemplateConditionModel(text: "使用安全词", isSelected: false),
        CreateTemplateConditionModel(text: "禁止录音录像", isSelected: false)
    ]
    enum Section: Int, CaseIterable {
        case content
        case conditions
    }
    
    enum Item: Hashable {
        case text
        case condition(CreateTemplateConditionModel)
    }
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    private var type = TemplateType.base
    var confirmClsoure: ((_ model:(content:String,conditions:[String])) -> Void)?
    
    convenience init(type: TemplateType) {
        self.init(nibName: nil, bundle: nil)
        self.type = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "协议内容"
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        let confirmButton = generalButton()
        confirmButton.setTitle("确认", for: .normal)
        view.addSubview(confirmButton)
        
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(kViewTopNaviHeight)
            make.bottom.equalTo(confirmButton.snp.top).offset(-10)
        }
        confirmButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(44)
        }
        weak var weakself = self
        confirmButton.addAction(UIAction(handler: { _ in
            guard let self = weakself else {
                return
            }
            let selectedConditions: [String] = self.conditions.filter { $0.isSelected }.map { $0.text }
            self.confirmClsoure?((self.type.text, selectedConditions))
            self.navigationController?.popViewController(animated: true)
        }), for: .touchUpInside)
        
        initDatasource()
        updateDatasource()
    }
    func updateDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([.text], toSection: .content)
        let items = conditions.map { Item.condition($0) }
        snapshot.appendItems(items, toSection: .conditions)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    func initDatasource() {
        weak var weakself = self
        
        let textCellRegistration = UICollectionView.CellRegistration<CreateTextCell, Item> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            cell.configure(content: weakself?.type.text ?? "")
        }
        let selectCellRegistration = UICollectionView.CellRegistration<CreateTemplate1ConditionCell, CreateTemplateConditionModel> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            let text = "\(indexPath.item+1). \(itemIdentifier.text)"
            cell.configure(condition: text, isSelected: itemIdentifier.isSelected)
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            guard let item = weakself?.dataSource.itemIdentifier(for: indexPath) else {
                return UICollectionViewCell()
            }
            switch item {
            case .text:
                return collectionView.dequeueConfiguredReusableCell(using: textCellRegistration, for: indexPath, item: itemIdentifier)
            case .condition(let createTemplateConditionModel):
                return collectionView.dequeueConfiguredReusableCell(using: selectCellRegistration, for: indexPath, item: createTemplateConditionModel)
            }
        })
        let headerViewRegistration = UICollectionView.SupplementaryRegistration<CreateSectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { (headerView, String, indexPath) in
            guard let section = weakself?.dataSource.sectionIdentifier(for: indexPath.section) else {
                return
            }
            switch section {
            case .content:
                headerView.configure(isRequired: false, title: "协议内容", tips: "")
            case .conditions:
                headerView.configure(isRequired: false, title: "安全措施", tips: "")
            }
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerViewRegistration, for: indexPath)
        }
    }
}

extension CreateTemplateVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return CGSize.zero
        }
        let width = collectionView.bounds.width - 40
        switch item {
        case .text:
            let height = CreateTextCell.getHeight(content: type.text, limitWidth: width)
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
        case .text:
            break
        case .condition(_):
            conditions[indexPath.row].isSelected.toggle()
            updateDatasource()
        }
    }
}
