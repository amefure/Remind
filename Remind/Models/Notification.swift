//
//  Notification.swift
//  Remind
//
//  Created by t&a on 2022/10/04.
//

import UIKit
import RealmSwift

class Notification: Object ,ObjectKeyIdentifiable{
    @Persisted(primaryKey: true) var id:UUID = UUID()
    @Persisted var body:String = ""
    @Persisted var date:Date = Date()
    
}
