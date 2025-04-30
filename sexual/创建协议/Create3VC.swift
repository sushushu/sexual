//
//  Create3VC.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import UIKit

class Create3VC: BaseViewController {

    private var model = AgreementModel()
    
    convenience init(model: AgreementModel) {
        self.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "创建协议"
        let stepImageView = UIImageView(frame: CGRect(x: 0, y: kViewTopNaviHeight, width: view.bounds.width, height: view.bounds.width*72.0/375))
        stepImageView.image = UIImage(named: "create_step_3")
        view.addSubview(stepImageView)
        
        let scrollView = UIScrollView()
        scrollView.layer.cornerRadius = 10
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        let nextButton = generalButton()
        nextButton.setTitle("生成协议", for: .normal)
        view.addSubview(nextButton)
        weak var weakself = self
        nextButton.addAction(UIAction(handler: { _ in
            // 创建 DateFormatter 实例
            let dateFormatter = DateFormatter()
            // 示例 1: 转换为 "yyyy-MM-dd" 格式的字符串
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = dateFormatter.string(from: Date())
            weakself?.model.generateDate = dateString
            guard let model = weakself?.model else {
                return
            }
            guard saveModel(model: model) else { return }
            
            guard var vcs = weakself?.navigationController?.viewControllers else {
                return
            }
            
            let minevc = MineAgreementListVC()
            vcs.removeSubrange(1..<vcs.count)
            vcs.append(minevc)
            weakself?.navigationController?.setViewControllers(vcs, animated: true)
        }), for: .touchUpInside)
        
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(stepImageView.snp.bottom)
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
        
        let agreementView = AgreementView()
        scrollView.addSubview(agreementView)
        agreementView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalTo(view).inset(10)
            make.bottom.equalToSuperview()
        }
        agreementView.setupUI(model: model, isSign: false)
    }
    
}
