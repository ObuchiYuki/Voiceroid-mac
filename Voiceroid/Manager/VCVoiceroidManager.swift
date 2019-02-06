//
//  VCVoiceroidManager.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/** Voiceroidの読み上げを管理します。(VCVoiceroidはManager層ではなくSys層です！ViewModelから触っちゃダメです！)
 通知
 - VCVoiceroidManagerStartProcesssing
 - VCVoiceroidManagerEndProcesssing
 を投げます。
*/
class VCVoiceroidManager {
    static let `default` = VCVoiceroidManager()
    
    /// VCConfigManagerの設定に基づいて音声を読み上げます。
    func sayWithCurrentConfig(){
        let currentConfig = VCConfigManager.default.createConfig()
        NotificationCenter.default.post(name: .VCVoiceroidManagerStartProcesssing, object: currentConfig)
        VCVoiceroid.say(config: currentConfig){
            NotificationCenter.default.post(name: .VCVoiceroidManagerEndProcesssing, object: currentConfig)
        }
    }
    
    /// VCConfigManagerの設定に基づいて音声を保存します。
    func saveFileWithCurrentConfig(at url:URL){
        let currentConfig = VCConfigManager.default.createConfig()
        NotificationCenter.default.post(name: .VCVoiceroidManagerStartProcesssing, object: currentConfig)
        VCVoiceroid.saveFile(config: currentConfig, at: url) {
            NotificationCenter.default.post(name: .VCVoiceroidManagerEndProcesssing, object: currentConfig)
        }
    }
}

extension Notification.Name{
    static let VCVoiceroidManagerStartProcesssing = Notification.Name(rawValue: "_VCVoiceroidManagerStartProcesssing")
    static let VCVoiceroidManagerEndProcesssing = Notification.Name(rawValue: "_VCVoiceroidManagerEndProcesssing")
}
