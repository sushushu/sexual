//
//  UtilityTools.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import Foundation
import UIKit
import SnapKit

let appThemeColor = hexColor(0xF1607D, alpha: 1.0) // 主题色

private let defaultsKey = "create"
func saveModel(model: AgreementModel) -> Bool {
    guard let dic = toDic(type: model) else {
        return false
    }
    if let array = UserDefaults.standard.array(forKey: defaultsKey) as? [[String:Any]] {
        var newArray = array
        newArray.insert(dic, at: 0)
        UserDefaults.standard.set(newArray, forKey: defaultsKey)
    } else {
        let newArray = [dic]
        UserDefaults.standard.set(newArray, forKey: defaultsKey)
    }
    return true
}
func deleteModel(index:Int) {
    guard let array = UserDefaults.standard.array(forKey: defaultsKey) as? [[String:Any]] else {
        return
    }
    var newArray = array
    if index >= 0 && index < newArray.count {
        newArray.remove(at: index)
    }
    UserDefaults.standard.set(newArray, forKey: defaultsKey)
}
func getModels() -> [AgreementModel] {
    guard let array = UserDefaults.standard.array(forKey: defaultsKey) as? [[String:Any]] else {
        return []
    }
    let models = toModel(type: [AgreementModel].self, json: array)
    return models ?? []
}
/// 转成模型
private func toModel<T:Decodable>(type:T.Type, json:Any) -> T? {
    do {
        let data = try JSONSerialization.data(withJSONObject: json)
        let decoder = JSONDecoder()
        // 把 下划线命名的变量 转换成通用的写法
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(T.self, from: data)
        return result
    } catch let error {
        print("解码出错: \(error)")
        return nil
    }
}
private func toDic<T:Encodable>(type:T) -> [String:Any]? {
    do {
        // 使用 JSONEncoder 进行编码
        let encoder = JSONEncoder()
        let jsonData = try encoder.encode(type)
        // 将 JSON 数据转换为字典
        let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
        return dictionary
    } catch {
        print("编码出错: \(error)")
        return nil
    }
}


func generalButton() -> UIButton {
    let button = UIButton(type: .system)
    button.setTitle("按钮", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.setBackgroundImage(generateSolidColorImage(color: appThemeColor), for: .normal)
    button.setBackgroundImage(generateSolidColorImage(color: hexColor(0xF9B1BF)), for: .disabled)
    button.layer.cornerRadius = 5
    button.clipsToBounds = true
    return button
}
func generateSolidColorImage(color: UIColor, size: CGSize = CGSize(width: 100, height: 100)) -> UIImage? {
    let renderer = UIGraphicsImageRenderer(size: size)
    
    return renderer.image { context in
        let cgContext = context.cgContext
        
        // 设置填充颜色
        cgContext.setFillColor(color.cgColor)
        
        // 绘制矩形并填充
        cgContext.fill(CGRect(origin: .zero, size: size))
    }
}
/// 返回十六进制颜色值对应的颜色
func hexColor(_ hexValue: Int, alpha: CGFloat = 1.0) -> UIColor {
    let red = CGFloat(CGFloat((hexValue & 0xFF0000) >> 16)/255.0)
    let green = CGFloat(CGFloat((hexValue & 0x00FF00) >> 8)/255.0)
    let blue = CGFloat(CGFloat((hexValue & 0x0000FF) >> 0)/255.0)
    return UIColor(red: red, green: green, blue: blue, alpha: alpha)
}
/// 根据效果图设置文字属性
func attributionString(_ text: String, font: UIFont, color: UIColor, lineHeight: CGFloat) -> NSAttributedString {
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font,
        .foregroundColor: color
    ]
    let attributedString = NSMutableAttributedString(string: text)
    attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
    
    let paragraphStyle = NSMutableParagraphStyle()
    //    paragraphStyle.lineSpacing = 10 // 设置行间距
    paragraphStyle.minimumLineHeight = lineHeight // 设置最小行高
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
    
    return attributedString
}

func attributionString(_ attributedText: NSAttributedString, lineHeight: CGFloat) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: attributedText.string)
    
    let paragraphStyle = NSMutableParagraphStyle()
    //    paragraphStyle.lineSpacing = 10 // 设置行间距
    paragraphStyle.minimumLineHeight = lineHeight // 设置最小行高
    attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
    
    return attributedString
}

/// 获取应用程序的主窗口
var kCurrentWindow:UIWindow? {
    if #available(iOS 13.0, *) {
        let connectedScenes = UIApplication.shared.connectedScenes
        let forgroundScene = connectedScenes.filter { $0.activationState == UIScene.ActivationState.foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        let windowScene = forgroundScene.first ?? connectedScenes.first as? UIWindowScene
        guard let windowScene else { return nil }
        if windowScene.windows.count == 1 {
            return windowScene.windows.first
        }
        return windowScene.windows.filter { $0.isKeyWindow }.first
    } else {
        return UIApplication.shared.keyWindow
    }
}
/// 状态栏高度,机型不同,数值不同,不是只有 20或 44
let kStatusBarHeight:CGFloat = kCurrentWindow?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0.0
/// 状态栏高度,动态获取,横屏和竖屏的高度不同
var kStatusBarDynamicHeight: CGFloat {
    return kCurrentWindow?.windowScene?.statusBarManager?.statusBarFrame.size.height ?? 0.0
}

/// 导航栏的高度,目前为固定值
let kNavigationBarHeight = 44.0
/// 获取导航栏+状态栏高度,代替之前上方的 64
let kViewTopNaviHeight = kStatusBarHeight + kNavigationBarHeight
/// 获取tabbar+底部安全区高度,代替之前下方的49
let kTabBarHeight:CGFloat = (kStatusBarHeight > 21.0 ? 83.0:49.0)
