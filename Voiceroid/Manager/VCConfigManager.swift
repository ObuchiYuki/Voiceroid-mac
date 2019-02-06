//
//  VCVoiceroidManager.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 ボイスロイド読み上げの設定を管理します。
 
 # 通知について
 VCVoiceroidManagerは
 話者、コンフィグが変更された時。
 - VCVoiceroidManagerConfigChanged
 - VCVoiceroidManagerSpeakerChanged
 を投げます。
 */
class VCConfigManager{
    // MARK: Singleton
    static let `default` = VCConfigManager()
    
    // MARK: VCVoiceroidManager Private Property
    private var _currentConfig = VCConfig(text: "", speaker: .yukari)
    
    /// 現在の設定された値からVCConfigを返します。
    /// VCVoiceoirdを呼び出すときに使用してください。
    func createConfig() -> VCConfig{
        return _currentConfig
    }
    func currentSpeaker() -> VCSpeaker{
        return _currentConfig.speaker
    }
    
    // MARK: VCVoiceroidManager Setting methods
    func setSpeaker(_ speaker: VCSpeaker){
        self._currentConfig.speaker = speaker
        _postSpeakerChangedNotification(with: speaker)
        _postConfigChangedNotification(with: _currentConfig)
    }
    func setText(_ text:String){
        self._currentConfig.text = text
        _postConfigChangedNotification(with: _currentConfig)
    }
    func setParamator(_ value:Double, for key:VCConfigParamatorKey){
        self._currentConfig.setParamator(value, for: key)
        _postConfigChangedNotification(with: _currentConfig)
    }
    
    // MARK: VCVoiceroidManager Private Methods
    private func _postConfigChangedNotification(with config:VCConfig){
        NotificationCenter.default.post(name: .VCConfigManagerConfigChanged, object: config)
    }
    private func _postSpeakerChangedNotification(with speaker:VCSpeaker){
        NotificationCenter.default.post(name: .VCConfigManagerSpeakerChanged, object: speaker)
    }
}

/// 通知発行用
extension Notification.Name{
    ///話者変更時に投げられます。senderObjectとして変更後のVCSpeakerを持ちます。
    static let VCConfigManagerSpeakerChanged = Notification.Name("_VCVoiceroidManagerSpeakerChanged")
    ///設定変更時に投げられます。senderObjectとして変更後のVCConfigを持ちます。
    static let VCConfigManagerConfigChanged = Notification.Name("_VCVoiceroidManagerConfigChanged")
}

