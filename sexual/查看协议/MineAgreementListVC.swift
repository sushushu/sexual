//
//  MineAgreementListVC.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class MineAgreementListVC: BaseViewController {
    enum Section {
        case main
    }
    
    private var collectionView:UICollectionView!
    private var dataSource:UICollectionViewDiffableDataSource<Section,AgreementModel>!
    private var emptyView = ListEmptyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的协议"
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: createLayout())
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
        }
        emptyView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { make in
            make.edges.equalTo(collectionView)
        }
        
        initDataSource()
        updateDataSource()
    }
    func updateDataSource() {
        let models = getModels()
        var snapshot = NSDiffableDataSourceSnapshot<Section,AgreementModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(models, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
        emptyView.isHidden = !models.isEmpty
    }
    func createLayout() -> UICollectionViewLayout {
        weak var weakself = self
        let layout = UICollectionViewCompositionalLayout.init { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.showsSeparators = false
            configuration.backgroundColor = .clear
            configuration.trailingSwipeActionsConfigurationProvider = { indexPath in
                let action = UIContextualAction(style: .destructive, title: "删除", handler: {(action, view, completion) in
                    print("swipe action triggered!?")
                    deleteModel(index: indexPath.item)
                    weakself?.updateDataSource()
                    
                    completion(true)
                })
                return UISwipeActionsConfiguration(actions: [action])
            }
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: layoutEnvironment)
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 16, leading: 16, bottom: 24, trailing: 16)
            return section
        }
        return layout
    }
    func initDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<MineAgreementListCell, AgreementModel> { cell, indexPath, itemIdentifier in
            cell.configure(sponsor: itemIdentifier.sponsor, invitee: itemIdentifier.invitee, time: itemIdentifier.generateDate)
        }
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        })
    }
}

extension MineAgreementListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        let vc = MineAgreementDetailVC(model: item)
        navigationController?.pushViewController(vc, animated: true)
    }
}
