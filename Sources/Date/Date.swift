//
//  ADTFoundation
//
//  Copyright (c) 2020 robin2005 - https://github.com/robin005
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE

import Foundation

public enum DateFormatMode : Int {
    case time
    case date
    case dateAndTime
    case countDownTimer
}

public extension Date {
    
    var now: Date{ return Date(timeIntervalSinceNow: 0) }
    
    static func format(toString date:Date,mode: DateFormatMode) -> String {
        let dateFormatter = setDateFormatter(mode: mode)
        return dateFormatter.string(from: date)
    }
    
    func format(mode: DateFormatMode) -> String {
        return Date.format(toString: self, mode: mode)
    }
    
    static func initWith(string: String, mode: DateFormatMode) -> Date? {
        let dateFormatter = setDateFormatter(mode: mode)
        guard let date = dateFormatter.date(from: string) else {
            return nil
        }
        return date
    }
    
    static func initWith(json: String, mode: DateFormatMode) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.date(from: json)
    }
    
    private static func setDateFormatter(mode: DateFormatMode) -> DateFormatter{
        let dateFormatter = DateFormatter()
        switch mode {
        case .countDownTimer:
            dateFormatter.dateFormat = "ss.A"
        case .date:
            dateFormatter.dateFormat = "yyyy-MM-dd"
        case .dateAndTime:
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.A"
        case .time:
            dateFormatter.dateFormat = "HH:mm:ss.A"
        }
        return dateFormatter
    }

    /// 根据服务器时间格式将字符串 -> 时间类
    ///
    /// 默认时间格式:MM-dd-yyyy
    /// 默认美国时区
    ///
    static func getDateFromServiceString(_ dateString:String,dateFormat:String = "MM-dd-yyyy" , timeZone:String = "America/Los_Angeles") -> Date {
        let sourceTimeZone = TimeZone(identifier: timeZone)
        let dateFormatter = DateFormatter.init()
        dateFormatter.timeZone = sourceTimeZone
        dateFormatter.dateFormat = dateFormat
       if let date = dateFormatter.date(from: dateString) {
           return date
       }
       dateFormatter.dateFormat = "yyyy-MM-dd"
       if let date = dateFormatter.date(from: dateString) {
           return date
       }
       return Date()
    }

    /// 根据时间服务器格式将时间类 -> 字符串
    ///
    /// 默认时间格式:yyyy-MM-dd HH:mm:ss
    /// 默认美国时区
    ///
    static func getTimeStrFromServiceDate (_ date:Date,dateFormat:String = "MM-dd-yyyy HH:mm:ss", timeZone:String = "America/Los_Angeles") -> String {
         let dateFormatter = DateFormatter.init()
         let sourceTimeZone = TimeZone(identifier: timeZone)
         dateFormatter.timeZone = sourceTimeZone
         dateFormatter.dateFormat = dateFormat
         let str = dateFormatter.string(from: date)
         return str
     }
 
    ///MARK:  通过出生日期获得 Age
    var age: Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }

}
