//
//  thpsextendstring.swift
//  
//
//  Created by Kostiantyn Bohonos on 2/7/22.
//

import Foundation

extension String
{
    var utf8Array: [UInt8] {
        return Array(utf8)
    }
    
    /// get left substing from string
    func left(_ n: Int) -> String {
        guard n >= 0 else {
            fatalError("n should never negative")
        }
        let index = self.index(self.startIndex, offsetBy: min(n, self.count))
        return String(self[..<index])
    }
    
    /// replace substring by string
    func replace(target: String, withString: String) -> String
    {
        self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    /// get CheckSum  CRC32 from string
    var checksumValue: String {
        String(format:"%llX", UInt64(thpsCS.checksum(bytes: self.utf8Array)))
    }
}
