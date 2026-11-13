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
        
        let checkBgView = UIView()
        view.addSubview(checkBgView)
        let checkButton = UIButton(type: .custom)
        checkBgView.addSubview(checkButton)
        checkButton.setImage(UIImage(named: "check_select"), for: .selected)
        checkButton.setImage(UIImage(named: "check_unselect"), for: .normal)
        checkBgView.addSubview(checkButton)
        let checkTipsLabel = UILabel()
        checkTipsLabel.numberOfLines = 2
        let font = UIFont.systemFont(ofSize: 13, weight: .regular)
        checkTipsLabel.attributedText = attributionString("我已知悉协议仅供沟通参考，任何一方都可以随时撤回同意", font: font, color: hexColor(000000, alpha: 0.65), lineHeight: 12)
        checkBgView.addSubview(checkTipsLabel)
        checkButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
        }
        checkTipsLabel.snp.makeConstraints { make in
            make.left.equalTo(checkButton.snp.right).offset(8)
            make.right.equalToSuperview().offset(-20)
            make.top.bottom.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        weak var weakself = self
        checkButton.addAction(UIAction(handler: { _ in
            checkButton.isSelected.toggle()
        }), for: .touchUpInside)
        
        let nextButton = generalButton()
        nextButton.setTitle("生成协议", for: .normal)
        view.addSubview(nextButton)
        nextButton.addAction(UIAction(handler: { _ in
            guard checkButton.isSelected else {
                let alert = UIAlertController(title: nil, message: "请仔细阅读协议内容，并勾选确认", preferredStyle: .alert)
                let action = UIAlertAction(title: "我已知晓", style: .default) { _ in
                    checkButton.isSelected.toggle()
                }
                alert.addAction(action)
                weakself?.present(alert, animated: true)
                return
            }
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
            make.bottom.equalTo(checkBgView.snp.top).offset(-10)
        }
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
        
        checkBgView.snp.makeConstraints { make in
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
            make.left.right.equalToSuperview()
            make.height.greaterThanOrEqualTo(40)
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
