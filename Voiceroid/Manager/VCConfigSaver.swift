//
//  VCConfigSaver.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

class VCConfigSaver {
    static let `default` = VCConfigSaver()

    /// 引数話者に対してのConfigが保存されていれば保存されたものを、
    /// 保存されていなければデフォルトのConfigを返します。
    func loadConfig(for speaker:VCSpeaker) -> VCConfig{
        if let savedConfig = RMStorage.shared.get(for: .key(for: speaker)){
            return savedConfig
        }
        return self._createDefaultConfig(for: speaker)
    }
    
    func removeSavedConfig(for speaker:VCSpeaker){
        RMStorage.shared.remove(with: .key(for: speaker))
    }
    
    /// AppDelegateから初期化してください。
    /// NotificationCenterへの通知監視有効化を行います。
    func initialize(){
        NotificationCenter.default.addObserver(forName: .VCConfigManagerConfigChanged, object: nil, queue: .main){_ in
            let config = VCConfigManager.default.createConfig()
            self._didConfigChanged(to: config)
        }
        
        NotificationCenter.default.addObserver(forName: .VCConfigManagerSpeakerChanged, object: nil, queue: .main){_ in
            let config = VCConfigManager.default.createConfig()
            self._didConfigChanged(to: config)
        }
    }
    
    /// 引数話者に対してのデフォルトコンフィグを返します。
    /// 保存されていなかったときに呼び出して♡
    private func _createDefaultConfig(for speaker:VCSpeaker) -> VCConfig{
        return VCConfig(text: "", speaker: speaker)
    }
    
    /// コンフィグが変更されたときに呼び出してください。
    /// 現在の話者に基づいたコンフィグを保存します。
    private func _didConfigChanged(to config:VCConfig){
        let currentSpeaker = VCConfigManager.default.currentSpeaker()
        RMStorage.shared.store(config, for: .key(for: currentSpeaker))
    }
}

private extension RMStorage.Key{
    /// 話者固有の保存用キーを生成します。
    static func key(for spekaer:VCSpeaker) -> RMStorage.Key<VCConfig> {
        return RMStorage.Key(rawValue: "VCConfigSaver.speaker.\(spekaer.name.lowercased())")
    }
}
