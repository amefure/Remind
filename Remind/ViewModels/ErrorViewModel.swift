//
//  ErrorViewModel.swift
//  Remind
//
//  Created by t&a on 2023/03/14.
//

import UIKit

class ErrorViewModel {
    
    public var model = ErrorModel.shared
    
    public func getError() -> NotificationError? {
        return self.model.currentError
    }
    
    public func displayErrorMsg() -> String{
        if self.model.currentError != nil {
            return self.model.currentError!.errorDescription!
        }else{
            return ""
        }
    }
  
}
