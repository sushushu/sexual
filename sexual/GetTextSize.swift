//
//  GetTextSize.swift
//  zlsj
//
//  Created by shen on 2025/1/21.
//

import Foundation
import UIKit

extension NSAttributedString {
    /// 计算文本所占空间大小
    func labelSize(limitWidth:CGFloat, limitHeight:CGFloat=CGFloat.greatestFiniteMagnitude) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        let size = CGSize(width: limitWidth, height: limitHeight) // 设置宽度，限制高度
        label.attributedText = self
        let labelSize = label.sizeThatFits(size)
        return labelSize
    }
}
extension String {
    /// 计算文本所占空间大小
    func labelSize(limitWidth:CGFloat, limitHeight:CGFloat=CGFloat.greatestFiniteMagnitude, font:UIFont) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        let size = CGSize(width: limitWidth, height: limitHeight) // 设置宽度，限制高度
        label.font = font
        label.text = self
        let labelSize = label.sizeThatFits(size)
        return labelSize
    }
}

/*
 /// boundingRectWithSize 可能存在显示是按两行显示但高度结算确只有一行的高度，就会导致计算不正确.可以使用Label的sizeThatFits方法：
 func size(limitWidth:CGFloat, limitHeight:CGFloat=CGFloat.greatestFiniteMagnitude, font:UIFont=UIFont.systemFont(ofSize: UIFont.systemFontSize), attributes: [NSAttributedString.Key: Any]=[:]) -> CGSize {
     var attributes: [NSAttributedString.Key: Any] = [.font: font] // 设置属性
     for (key,value) in attributes {
         attributes.updateValue(value, forKey: key)
     }
     let size = CGSize(width: limitWidth, height: limitHeight) // 设置宽度，限制高度
     // 计算边界矩形
     let boundingRect = self.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil
     )
     return boundingRect.size
 }*/
