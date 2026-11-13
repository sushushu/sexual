//
//  MineAgreementDetailVC.swift
//  sexual
//
//  Created by shen on 2025/4/30.
//

import UIKit

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
        scrollView.contentInsetAdjustmentBehavior = .never
        view.addSubview(scrollView)
        
        let nextButton = generalButton()
        nextButton.setTitle("导出协议", for: .normal)
        view.addSubview(nextButton)
        nextButton.addAction(UIAction { [weak self, weak nextButton] _ in
            guard let self, let nextButton else { return }
            self.chooseExportFormat(source: nextButton)
        }, for: .touchUpInside)

        scrollView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.bottom.equalTo(nextButton.snp.top).offset(-10)
        }
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
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
    private func chooseExportFormat(source: UIView) {
        let alert = UIAlertController(title: "导出协议", message: "协议包含个人信息，请谨慎分享。", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "导出 PDF", style: .default) { [weak self] _ in
            self?.export(.pdf, source: source)
        })
        alert.addAction(UIAlertAction(title: "导出图片", style: .default) { [weak self] _ in
            self?.export(.image, source: source)
        })
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.popoverPresentationController?.sourceView = source
        alert.popoverPresentationController?.sourceRect = source.bounds
        present(alert, animated: true)
    }

    private func export(_ format: AgreementExporter.Format, source: UIView) {
        guard let model else { return }
        do {
            let url = try AgreementExporter.export(model, format: format)
            let activity = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            activity.popoverPresentationController?.sourceView = source
            activity.popoverPresentationController?.sourceRect = source.bounds
            present(activity, animated: true)
        } catch {
            let message = error is AgreementExporter.ExportError ? "图片过长或生成失败，请尝试导出 PDF。" : "无法生成文件，请稍后重试。"
            let alert = UIAlertController(title: "导出失败", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "知道了", style: .default))
            present(alert, animated: true)
        }
    }
}
