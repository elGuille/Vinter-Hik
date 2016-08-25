//
//  FileManager.swift
//  Vinter
//
//  Created by Guillermo García on 11/08/16.
//  Copyright © 2016 Vinter. All rights reserved.
//

import Foundation

class FileManager {
    
    let fileManager = Foundation.FileManager.default
    var filePath: String?
    var fileName: String?
    var fullPath: String { return "\(filePath)/\(fileName)" }
    
    var directoryExists: Bool { var isDir = ObjCBool(true) ; return fileManager.fileExists(atPath: filePath!, isDirectory: &isDir) }
    var fileExists: Bool { return fileManager.fileExists(atPath: "\(filePath!)/\(fileName!)") }
    
    init(path: String, fileName: String) { filePath = path ; self.fileName = fileName }
    
    func createDirectory() -> Bool {
        if directoryExists { return false }
        do { try fileManager.createDirectory(atPath: filePath!, withIntermediateDirectories: false, attributes: nil) } catch { return false }
        return true
    }
    
    func deleteDirectory() -> Bool {
        if !directoryExists || fileExists { return false }
        do { try fileManager.removeItem(atPath: filePath!) } catch { return false }
        filePath = nil
        return true
    }
    
    func deleteFile() -> Bool {
        if !fileExists { return false }
        do { try fileManager.removeItem(atPath: fileName!) } catch { return false }
        fileName = nil
        return true
    }
    
    func moveFile(_ newPath: String) -> Bool {
        if !fileExists { return false }
        do { try fileManager.moveItem(atPath: filePath!, toPath: newPath) } catch { return false }
        return true
    }
    
}
