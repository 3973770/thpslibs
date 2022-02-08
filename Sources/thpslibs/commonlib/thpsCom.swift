//
//  thpsCom.swift
//  
//
//  Created by Kostiantyn Bohonos on 2/7/22.
//

import Foundation

// MARK: COMMON
//--------------------------------------

public struct thpsCom{
    private static var StartYearTI:TimeInterval = thpsDT.Calendarlib.startOfYear(Date()).timeIntervalSince1970
    
    /// return null idd
    public static func GenIDDNull(_ pref:UInt64) ->UInt64 {
        let mnozh:UInt64 = 10000000000000000
        return pref*mnozh
    }
    
    /// return random idd with prefix
    public static func GenIDD(_ pref:UInt64) ->UInt64 {
        let mnozh:UInt64 = 10000000000000000
        return pref*mnozh + UInt64((Date().timeIntervalSince1970-StartYearTI)*100000000)  + UInt64.random(in: 0 ... 6855039999999999)
    }
    
    /// return UUID
    public static func NewUUID() -> String {
        UUID().uuidString
    }
    
    /// return UUID with pref
    public static func NewUUID(_ pref:String) -> String {
        "\(pref)\(UUID().uuidString)"
    }
    
}
