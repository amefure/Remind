//
//  ErrorModel.swift
//  Remind
//
//  Created by t&a on 2023/03/14.
//

import UIKit

class ErrorModel {
    
    // MARK: - シングルトンインスタンス
    static var shared = ErrorModel()
    //MARK: - カレントエラー
    public var currentError:NotificationError? = nil
    
    public func setCurrentError(_ error:NotificationError) {
        self.currentError = error
    }
}
