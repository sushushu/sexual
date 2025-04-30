//
//  CreateTemplateConditionModel.swift
//  sexual
//
//  Created by shen on 2025/4/29.
//

import Foundation

struct CreateTemplateConditionModel: Hashable {
    static func == (lhs: CreateTemplateConditionModel, rhs: CreateTemplateConditionModel) -> Bool {
        return lhs.text == rhs.text && lhs.isSelected == rhs.isSelected
    }
    
    let text:String
    var isSelected:Bool
    
}
