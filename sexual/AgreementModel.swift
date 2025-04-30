//
//  AgreementModel.swift
//  sexual
//
//  Created by shen on 2025/4/28.
//

import Foundation

let modelValueChangeNotification = Notification.Name(rawValue: "AgreementModelValueChange")

struct AgreementModel: Codable, Hashable {
    var createDate:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 发起方
    var sponsor:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 身份证号 = ""
    var sponsorCardId:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 被邀请方:String = ""
    var invitee:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 身份证号:String = ""
    var inviteeCardId:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 协议详情:String = ""
    var content:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 安全措施:String = ""
    var conditions:[String] = [] {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 开始时间:String = ""
    var startDate:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 结束时间:String = ""
    var endDate:String = "" {
        didSet {
            NotificationCenter.default.post(name: modelValueChangeNotification, object: nil)
        }
    }
    // 隐私条款:String = ""
    var privacy:String = "我们承诺对本次关系的细节保持私密，不向第三方分享对方的隐私信息。未经明确同意，不得分享、发布或传播与对方相关的任何信息、照片或录像。此外，我们同意在社交媒体上不发布任何可能暗示或揭示我们关系的内容。"
    // 撤回条款:String = ""
    var regret:String = "任何一方都可以在任何时候撤回同意，而无需提供理由。我们同意使用安全词系统：红灯表示立即停止当前行为；黄灯表示放慢或调整当前行为。一旦安全词被使用，另一方应立即响应并停止或调整行为。"
    var additional:String = ""
    
    var generateDate:String = ""
    
    var title:String {
        return "性行为同意协议-\(createDate)"
    }
}
