//
//  VCFileSaveManager.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/02.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit
import Foundation

class VCFileSaveManager {
    static let `default` = VCFileSaveManager()
    
    /// 保存するパスを返します。
    /// 存在しなかった場合は、Documentを返します。
    func saveUrl() -> URL{
        return _createFilePath(for: saveDirectory())
    }
    func saveDirectory() -> URL{
        if let url = RMStorage.shared.get(for: ._saveURLKey) {
            return url
        }
        let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return URL(fileURLWithPath: documentPath)
    }

    private func _createFilePath(for dir:URL) -> URL{
        var count = 0
        func genfilename(_ count: Int) -> URL{
            return dir.appendingPathComponent(String(format: "%04d", count) + ".wav")
        }
        while FileManager.default.fileExists(atPath: genfilename(count).path) {
            count += 1
        }
        return genfilename(count)
    }
    
    func setSaveUrl(_ url:URL){
        RMStorage.shared.store(url, for: ._saveURLKey)
    }
    
    func showModal(_ completion:@escaping (URL)->()){
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canChooseFiles = false
        openPanel.canCreateDirectories = false
        
        openPanel.beginSheetModal(for: NSApplication.shared.mainWindow!) {result in
            if result == NSApplication.ModalResponse.OK {
                guard let url = openPanel.url else {return}
                completion(url)
            }
        }
    }
}

