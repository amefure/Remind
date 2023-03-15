//
//  DisplayDateViewModel.swift
//  Remind
//
//  Created by t&a on 2023/03/07.
//

import UIKit

class DisplayDateViewModel {
    // MARK: - 日付表示用モデル
    // DateFormatterをプロパティに持つ
    // 日付の表示形式を変更する
    
    private let df:DateFormatter = DateFormatter()
    
    init(){
        df.calendar = Calendar(identifier: .gregorian)
        df.locale = Locale(identifier: "ja_JP")
        df.timeZone = TimeZone(identifier: "Asia/Tokyo")
    }
    /// 時間のみ表示用
    public func getTimeDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "H時mm分"
        return df.string(from: date)
    }
    
    /// 日付のみ表示用
    public func getDateDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "yyyy年M月d日"
        return df.string(from: date)
    }
    
    /// 全て表示用(改行あり)
    public func getAllDisplayFormatString(_ date:Date) -> String{
        df.dateFormat = "yyyy年\nM月d日\nH時mm分"
        return df.string(from: date)
    }
    /// 全て表示用(改行なし)
    public func getAllDisplayFormatStringNoReturn(_ date:Date) -> String{
        if DeviceSizeModel.calendar.identifier == .japanese {
            df.calendar = Calendar(identifier: .japanese)
            df.dateFormat = "Gy年M月d日H時mm分"
        }else{
            df.calendar = Calendar(identifier: .gregorian)
            df.dateFormat = "yyyy年M月d日H時mm分"
        }
        
        return df.string(from: date)
    }
    
    /// 通知登録用
    public func getNoticeFormatString(_ date:Date) -> String{
        if DeviceSizeModel.calendar.identifier == .japanese {
            df.calendar = Calendar(identifier: .japanese)
        }else{
            df.calendar = Calendar(identifier: .gregorian)
        }
        df.dateFormat = "yyyy-MM-dd-H-m"
        return df.string(from: date)
    }

}
