//
//  thpsDT.swift
//  
//
//  Created by Kostiantyn Bohonos on 2/7/22.
//

import Foundation

// MARK: DATE TIME
//--------------------------------------
struct thpsDT{
    private static var DFL:[String:DateFormatter] = [:]
    public  static var Calendarlib: Calendar = Calendar(identifier: .iso8601)
    
    
    /// get date formatter
    public static func GetDF(_ format:String,_ locale:String = "ru_RU") -> DateFormatter{
        var DF:DateFormatter?
        if DFL.keys.contains(format) {
            DF = DFL[format]
        }else{
            DF = DateFormatter()
            DF!.calendar = Calendar(identifier: .iso8601)
            DF!.locale = Locale(identifier: locale)
            DF!.timeZone = TimeZone.current
            //TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
            DF!.dateFormat = format
            DFL[format] = DF!
        }
        return DF!
    }
    
    /// Return date as string by format
    public static func DT_STR_FORMAT(_ date:Date,_ format:String) -> String{
        var res = ""
        #if os(OSX)
        autoreleasepool {
            res = GetDF(format).string(from: date)
        }
        #else
        res = GetDF(format).string(from: date)
        #endif
        return res
    }
    
    private static func STR_DT_Format(_ date: String,_ format:String) -> Date{
        var res:Date?
        #if os(OSX)
        autoreleasepool {
            res = GetDF(format).date(from: date)
        }
        #else
        res = GetDF(format).date(from: date)
        #endif
        return res!
    }
    
    /// return current moment as yyyyMMddHHmmssSSS
    public static func DT_moment() -> String {
        return DT_STR_FORMAT(Date(),"yyyyMMddHHmmssSSS")
    }
    
    /// return current date as yyyyMMdd
    public static func DT_yyyyMMdd(_ date:Date) -> String {
        return DT_STR_FORMAT(date,"yyyyMMdd")
    }
    
    /// return current moment as yyyy|MM|dd|HH|mm|ss|SSS
    public static func DT_momentW() -> String {
        return DT_STR_FORMAT(Date(),"yyyy|MM|dd|HH|mm|ss|SSS")
    }
    
    /// return day week  as Int8
    public static func DT_dayofweek(_ date:Date) -> Int8 {
        return Int8(Calendarlib.dayOfWeek(date))
    }
    
    public static func DT_YYYYMMDD(_ date: String) -> Date
    {
        return STR_DT_Format(date,"yyyyMMdd")
    }
    
    /// return start of day
    public static func DT_StartOfDay(_ date:Date) -> Date{
       return self.DT_YYYYMMDD(self.DT_yyyyMMdd(date))
    }
    
    public static func DT_YYYYMMDDHHmmss(_ date: String) -> Date
    {
        return STR_DT_Format(date,"yyyyMMddHHmmss")
    }
    
    /// return end of day
    public static func DT_EndOfDay(_ dt:Date) -> Date{
       return self.DT_YYYYMMDDHHmmss("\(self.DT_yyyyMMdd(dt))235959")
    }
    
    /// return current moment as Int64
    public static func DT_momentI() -> Int64 {
        let nowDouble = NSDate().timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    /// return datetime as Int64
    public static func DT_momentI(_ date:Date) -> Int64 {
        let nowDouble = date.timeIntervalSince1970
        return Int64(nowDouble*1000)
    }
    
    /// return current moment as Double
    public static func DT_momentD() -> Double {
        return NSDate().timeIntervalSince1970
    }
    
    public static var CurrentMoment:Date{
        Date()
    }
    
    public static func CurrentMomentAdd(d:Int64 = 0,h:Int64 = 0,m:Int64 = 0,s:Int64 = 0) -> Date{
        let s = (d*24*60*60)+(h*60*60)+(m*60)+s
        let sec = Double(s)
        return CurrentMoment.addingTimeInterval(TimeInterval(sec))
    }
    
    public static func CurrentMomentAdd(d:Int64 = 0,h:Int64 = 0,m:Int64 = 0,s:Int64 = 0) -> Int64{
        return  self.DT_momentI(self.CurrentMomentAdd(d:d,h:h,m:m,s:s))
    }
    
    public static func DT_Nil() -> Date{
        return Date(timeIntervalSince1970: 0);
    }
    
    public static func DT_isNil(_ date:Date) -> Bool{
        var ret:Bool = true;
        if date != Date(timeIntervalSince1970: 0) {
            ret = false;
        }
        return ret;
    }
    
    public static func DT_DisplayUTC(_ dt:Date) -> String{
        let format = "E, d MMM yyyy HH:mm:ss O"
        var DF:DateFormatter?
        if DFL.keys.contains(format) {
            DF = DFL[format]
        }else{
            DF = DateFormatter()
            DF!.calendar = Calendar(identifier: .iso8601)
            DF!.locale = Locale(identifier: "en_US_POSIX")
            DF!.timeZone = TimeZone(abbreviation: "UTC")
            DF!.dateFormat = format
            DFL[format] = DF
        }
        return DF!.string(from: dt)
    }
    
    // Display date time with format from enum thpsDTDisplayFormat
    public static func DT_Display(_ dt:Date,_ dtf:thpsDTDisplayFormat) -> String{
        return DT_STR_FORMAT(dt,dtf.rawValue)
    }
    // Display date time with format like string
    public static func DT_Display(_ dt:Date,_ dtf:String) -> String{
        return DT_STR_FORMAT(dt,dtf)
    }
}

/// enum template of display date format
public enum thpsDTDisplayFormat:String{
    /// format like as  = 07 февр. 21:24:11
    case DMMHMS  = "dd MMM HH:mm:ss"
    /// format like as  = 07 февр. 2022 21:24:11
    case DMMYHMS = "dd MMM yyyy HH:mm:ss"
    /// format like as  = 2022.02.07 21:24:11
    case YMDHMS  = "yyyy.MM.dd HH:mm:ss"
    /// format like as  = 07.02.2022
    case DMY = "dd.MM.yyyy"
    /// format like as  = 2022.02.07
    case YMD = "yyyy.MM.dd"
    /// format like as  = 21:24:11
    case HMS = "HH:mm:ss"
    /// format like as  = 212411
    case HMSC = "HHmmss"
}
