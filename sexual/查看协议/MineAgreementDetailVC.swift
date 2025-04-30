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
        title = "我的协议"
        guard let model else { return }
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        let nextButton = generalButton()
        nextButton.setTitle("保存PDF", for: .normal)
        view.addSubview(nextButton)
        weak var weakself = self
        nextButton.addAction(UIAction(handler: { _ in
            weakself?.generatePDF()
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
        let agreementView = AgreementView()
        v1.addSubview(agreementView)
        agreementView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalTo(pageWidth)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
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
