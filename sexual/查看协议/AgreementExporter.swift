import UIKit

struct AgreementExporter {
    enum Format { case pdf, image }
    enum ExportError: Error { case imageTooLong, encodingFailed }

    static func export(_ model: AgreementModel, format: Format) throws -> URL {
        let text = content(model)
        let data: Data
        let ext: String
        switch format {
        case .pdf:
            data = pdf(text)
            ext = "pdf"
        case .image:
            data = try image(text)
            ext = "png"
        }
        let directory = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)
        let url = directory.appendingPathComponent("性同意协议").appendingPathExtension(ext)
        try data.write(to: url, options: .atomic)
        return url
    }

    private static func content(_ model: AgreementModel) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        style.paragraphSpacing = 12
        let result = NSMutableAttributedString(string: "", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black, .paragraphStyle: style])
        func append(_ title: String, _ value: String) {
            let heading = NSAttributedString(string: "\(title)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 17), .foregroundColor: UIColor.black, .paragraphStyle: style])
            result.append(heading)
            result.append(NSAttributedString(string: "\(value.isEmpty ? "无" : value)\n", attributes: [.font: UIFont.systemFont(ofSize: 16), .foregroundColor: UIColor.black, .paragraphStyle: style]))
        }
        append("重要提示", "本协议仅供沟通参考，不能替代持续的同意与沟通。任何一方都可以随时撤回同意。")
        append("协议标题", model.title)
        append("创建日期", model.createDate)
        append("发起方", model.sponsor)
        append("发起方身份证号", model.sponsorCardId)
        append("被邀请方", model.invitee)
        append("被邀请方身份证号", model.inviteeCardId)
        append("协议详情", model.content)
        append("安全措施", model.conditions.joined(separator: "\n"))
        append("约定时间", "\(model.startDate) - \(model.endDate)")
        append("隐私条款", model.privacy)
        append("撤回同意条款", model.regret)
        append("附加条款", model.additional)
        if !model.generateDate.isEmpty { append("记录生成时间", model.generateDate) }
        return result
    }

    private static func pdf(_ text: NSAttributedString) -> Data {
        let page = CGRect(x: 0, y: 0, width: 595, height: 842)
        let formatter = UISimpleTextPrintFormatter(attributedText: text)
        formatter.perPageContentInsets = UIEdgeInsets(top: 36, left: 36, bottom: 36, right: 36)
        let renderer = UIPrintPageRenderer()
        renderer.addPrintFormatter(formatter, startingAtPageAt: 0)
        renderer.setValue(NSValue(cgRect: page), forKey: "paperRect")
        renderer.setValue(NSValue(cgRect: page), forKey: "printableRect")
        let pdf = UIGraphicsPDFRenderer(bounds: page)
        return pdf.pdfData { context in
            renderer.prepare(forDrawingPages: NSRange(location: 0, length: 0))
            for index in 0..<renderer.numberOfPages {
                context.beginPage()
                renderer.drawPage(at: index, in: page)
            }
        }
    }

    private static func image(_ text: NSAttributedString) throws -> Data {
        let width: CGFloat = 595
        let inset: CGFloat = 36
        let bounds = text.boundingRect(with: CGSize(width: width - inset * 2, height: .greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        let height = ceil(bounds.height) + inset * 2
        guard height <= 16000 else { throw ExportError.imageTooLong }
        let format = UIGraphicsImageRendererFormat()
        format.scale = 2
        format.opaque = true
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height), format: format)
        let rendered = renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(x: 0, y: 0, width: width, height: height))
            text.draw(with: CGRect(x: inset, y: inset, width: width - inset * 2, height: height - inset * 2), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        }
        guard let data = rendered.pngData() else { throw ExportError.encodingFailed }
        return data
    }
}
