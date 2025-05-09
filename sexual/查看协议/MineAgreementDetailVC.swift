//
//  MineAgreementDetailVC.swift
//  sexual
//
//  Created by shen on 2025/4/30.
//

import UIKit
import PDFGenerator
import PDFKit

class MineAgreementDetailVC: BaseViewController {
    private var model: AgreementModel?
    
    convenience init(model: AgreementModel) {
        self.init(nibName: nil, bundle: nil)
        self.model = model
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "我的记录"
        guard let model else { return }
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        let nextButton = generalButton()
        nextButton.setTitle("导出PDF参考", for: .normal)
        view.addSubview(nextButton)
        weak var weakself = self
        nextButton.addAction(UIAction(handler: { _ in
            // 显示免责声明提示
            let alert = UIAlertController(
                title: "导出提示",
                message: "导出的PDF仅作为沟通参考，不具备任何法律效力。双方可随时重新沟通并更新意愿。\n\n此记录仅代表沟通时的意愿，可能随实际情况变化。",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "确认导出", style: .default, handler: { _ in
                weakself?.generatePDF()
            }))
            
            weakself?.present(alert, animated: true)
        }), for: .touchUpInside)
        
        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview().offset(kViewTopNaviHeight)
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
        agreementView.setupUI(model: model, isSign: true)
    }
    func generatePDF() {
        guard let model else { return }
        // 设置页面大小（A4）
        let pageWidth = CGFloat(595.2) // A4 width in points
        let pageHeight = CGFloat(841.8) // A4 height in points
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let v1 = UIScrollView(frame: pageRect)
        
        // 添加顶部免责声明
        let disclaimerLabel = UILabel(frame: CGRect(x: 0, y: 0, width: pageWidth, height: 68))
        disclaimerLabel.text = "此记录仅作为沟通参考，不具备任何法律效力。记录仅代表沟通时的意愿，可能随时变化。"
        disclaimerLabel.textColor = .red
        disclaimerLabel.textAlignment = .center
        disclaimerLabel.numberOfLines = 0
        disclaimerLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        disclaimerLabel.backgroundColor = UIColor(red: 1.0, green: 0.9, blue: 0.9, alpha: 0.7)
        v1.addSubview(disclaimerLabel)
        
        // 添加记录内容视图，顶部留出免责声明空间
        let agreementView = AgreementView()
        v1.addSubview(agreementView)
        agreementView.frame = CGRect(x: 0, y: 60, width: pageWidth, height: pageHeight-60)
        agreementView.setupUI(model: model, isSign: true)
        
        v1.layoutIfNeeded()
        guard let docUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = docUrl.appendingPathComponent(model.title + ".pdf")
        do {
            try PDFGenerator.generate(v1, to: fileUrl)
        } catch (let e) {
            print(e)
        }
        let activity = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
        present(activity, animated: true)
    }
}
