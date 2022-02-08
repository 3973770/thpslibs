//
//  thpsFS.swift
//  
//
//  Created by Kostiantyn Bohonos on 2/7/22.
//

import Foundation

public struct thpsFS {
    
    public static func FileRemove(_ Path:String){
        if(FileManager.default.fileExists(atPath: Path)){
            do {
                try FileManager.default.removeItem(atPath: Path)
            }
            catch {
                print(error)
            }
        }
    }
    
    public static func FileExists(_ Path:String)-> Bool{
        FileManager.default.fileExists(atPath: Path)
    }
    
    public static func DirectoryExists(_ Path:String)-> Bool{
        var isDir : ObjCBool = false
        if FileManager.default.fileExists(atPath: Path, isDirectory:&isDir) {
            if !isDir.boolValue {
                return false
            }
        }else{
            return false
        }
        return true
    }
    
    public static func CreateDirectory(_ Path:String){
        if !DirectoryExists(Path) {
            do{
                try FileManager.default.createDirectory(atPath: Path, withIntermediateDirectories: true, attributes: nil)
            }catch{
                print(error)
            }
        }
    }
    
    public static func ListOfDirectory(_ Path:String) -> [String]{
        var res:[String] = [String]()
        if DirectoryExists(Path) {
            do {
                res = try FileManager.default.contentsOfDirectory(atPath: Path)
            } catch {
                print(error)
            }
        }
        return res
    }
}
