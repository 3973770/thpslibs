import Foundation

public struct thpslibs {
    public private(set) var version = "0.1.0"
    public var ver:String{
        self.version
    }
    public init() {
        thpsDT.Calendarlib.timeZone = TimeZone(secondsFromGMT: 0)!
    }
}
