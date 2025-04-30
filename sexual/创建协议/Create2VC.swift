//
//  Create2VC.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class Create2VC: BaseViewController {

    enum Section: Int, CaseIterable {
        case privacy
        case regret
        case additional
    }
    
    enum Item: Hashable {
        case privacy(String)
        case regret(String)
        case additional(String)
    }
    
    private var model = AgreementModel()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    convenience init(model: AgreementModel) {
        self.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "创建协议"
        let stepImageView = UIImageView(frame: CGRect(x: 0, y: kViewTopNaviHeight, width: view.bounds.width, height: view.bounds.width*72.0/375))
        stepImageView.image = UIImage(named: "create_step_2")
        view.addSubview(stepImageView)
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.layer.cornerRadius = 10
        collectionView.showsVerticalScrollIndicator = false
        view.addSubview(collectionView)
        
        let nextButton = generalButton()
        nextButton.setTitle("下一步", for: .normal)
        view.addSubview(nextButton)
        weak var weakself = self
        nextButton.addAction(UIAction(handler: { _ in
            guard let model = weakself?.model else {
                return
            }
            let vc = Create3VC(model: model)
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
        
        initDatasource()
        updateDatasource()
    }
    func updateDatasource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems([.privacy(model.privacy)], toSection: .privacy)
        snapshot.appendItems([.regret(model.regret)], toSection: .regret)
        snapshot.appendItems([.additional(model.additional)], toSection: .additional)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    func initDatasource() {
        weak var weakself = self
        let textViewCellRegistration = UICollectionView.CellRegistration<CreateTextViewCell, Item> { cell, indexPath, itemIdentifier in
            cell.backgroundColor = hexColor(0xF7F7F8)
            switch itemIdentifier {
            case .privacy(let string):
                cell.configure(text: string)
                cell.textViewDidEndEdit =  { text in
                    weakself?.model.privacy = text
                }
            case .regret(let string):
                cell.configure(text: string)
                cell.textViewDidEndEdit =  { text in
                    weakself?.model.regret = text
                }
            case .additional(let string):
                cell.configure(text: string)
                cell.textViewDidEndEdit =  { text in
                    weakself?.model.additional = text
                }
            }
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: textViewCellRegistration, for: indexPath, item: itemIdentifier)
        })
        let headerViewRegistration = UICollectionView.SupplementaryRegistration<CreateSectionHeaderView>(elementKind: UICollectionView.elementKindSectionHeader) { (headerView, String, indexPath) in
            guard let section = weakself?.dataSource.sectionIdentifier(for: indexPath.section) else {
                return
            }
            switch section {
            case .privacy:
                headerView.configure(isRequired: false, title: "隐私条款", tips: "")
            case .regret:
                headerView.configure(isRequired: false, title: "撤回同意条款", tips: "")
            case .additional:
                headerView.configure(isRequired: false, title: "额外条款", tips: "(可选)")
            }
        }
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerViewRegistration, for: indexPath)
        }
    }
}

extension Create2VC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return CGSize.zero
        }
        let width = collectionView.bounds.width-40
//        switch item {
//        case .privacy(let text):
//            let height = CreateTextCell.getHeight(content: text, limitWidth: width)
//            return CGSize(width: width, height: height)
//        case .regret(let text):
//            let height = CreateTextCell.getHeight(content: text, limitWidth: width)
//            return CGSize(width: width, height: height)
//        case .additional(_):
//            return CGSize(width: width, height: 140)
//        }
        return CGSize(width: width, height: 130)
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
}
