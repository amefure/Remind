//
//  NotificationError.swift
//  Remind
//
//  Created by t&a on 2023/03/14.
//

import UIKit

enum NotificationError: Error {
    case authorizationDenied       // 通知の許可が拒否された場合、、
    case notificationCenterFailed  // 通知センターでの処理に失敗した場合
    case notificationRequestFailed // 通知リクエストの処理に失敗
    
    var errorDescription: String? {
        switch self {
        case .authorizationDenied:
            return "設定でアプリからの通知が拒否されています"
        case .notificationCenterFailed:
            return "なんらかの理由で通知情報を参照することができません"
        case .notificationRequestFailed:
            return "なんらかの理由で通知の登録に失敗しました"
        }
        
        }
}

