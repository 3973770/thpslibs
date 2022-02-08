//
//  thpsNum.swift
//  
//
//  Created by Kostiantyn Bohonos on 2/7/22.
//

import Foundation

// MARK: NUMBERS
//--------------------------------------

public struct thpsNum{
    /// convert Int32 to string HEX
    static func HEX(_ number:Int32) ->String{
        return HEX(UInt64(number))
    }
    
    /// convert Uint64 to string HEX
    static func HEX(_ number:UInt64) ->String{
        return String(format:"%llX", number)
    }
    
    /// convert string HEX to Uint64
    static func XUInt64(_ hex:String) ->UInt64{
        var res:UInt64 = 0
        if( hex.count > 0 ){
            res = UInt64(hex, radix: 16)!
        }
        return res
    }
    
    /// extract prefix from UInt64 idd
    static func Pref(_ idd:UInt64) ->UInt64{
        let mnozh:UInt64 = 10000000000000000
        return idd/mnozh
    }
    
    /// conver float to Int64
    static func FTOI(_ number:String) -> Int64{
        var str = number;
        if(str == "" ){
            str = "0";
        }
        let index = str.firstIndex(of: ".")
        if (index == nil){
            str = "\(str)0000"
        }else{
            let i = str.index(index!, offsetBy: 1)
            let tmp = String(str[i...])
            var count = 4-tmp.count
            while count>0 {
                str = "\(str)0";
                count -= 1;
            }
            str = str.replacingOccurrences(of: ".", with: "")
        }
        
        return Int64(str)!;
    }
    
    static func FormatNumber(_ number:Int64,_ fract_:Int = 2,_ compact:Bool = false, _ delimeter:String = " ",_ delimeterFract:String = ",") ->String{
        var res = ""
        var tmp = "\(number)"
        var negative = false
        
        if tmp.hasPrefix("-") {
            negative = true;
            let index = tmp.firstIndex(of: "-")!
            let i = tmp.index(index, offsetBy: 1)
            tmp = String(tmp[i...])
        }
        var fract = String(tmp.suffix(4)) // playground
        while fract.count<4{
            fract = "0\(fract)"
        }
        if tmp.count > 4 {
            tmp = String(tmp.prefix(tmp.count-4))
        }else{
            tmp = ""
        }
        
        fract = String(fract.prefix(fract_))
        
        if compact {
            res = tmp;
        }else{
            while (true) {
                let thre = String(tmp.suffix(3))
                if thre.count == 0 {
                    break
                }else{
                    if tmp.count>3{
                        tmp = String(tmp.prefix(tmp.count-3));
                    }else{
                        tmp = ""
                    }
                    if res.count != 0 {
                        res = "\(delimeter)\(res)"
                    }
                    res = "\(thre)\(res)"
                }
            }
        }
        if res.count==0 {
            res = "0"
        }
        
        if fract_>0 {
            res = "\(res)\(delimeterFract)\(fract)"
        }
        if negative {
            res = "-\(compact ? "" : " ")\(res)"
        }
        return res
    }
    
}
