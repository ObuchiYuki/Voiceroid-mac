//
//  _VCMainMenuModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/28.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

protocol _VCMainMenuModelBinder: class {
    func changeSaveMenuState(_ enabled:Bool)
}

class _VCMainMenuModel {
    weak var binder:_VCMainMenuModelBinder?
    
    init() {
        NotificationCenter.default.addObserver(forName: .VCConfigManagerConfigChanged, object: nil, queue: .main){notice in
            guard let config = notice.object as? VCConfig else {return}
            self._configDidChange(to: config)
        }
    }
    private func _configDidChange(to config:VCConfig){
        let enabled = self._canExcuteVoiceroid(with: config)
        binder?.changeSaveMenuState(enabled)
    }
    private func _canExcuteVoiceroid(with config:VCConfig) -> Bool{
        if config.text.isEmpty{
            return false
        }
        return true
    }
    
    func didSaveMenuClicked() {
        let saveUrl = VCFileSaveManager.default.saveUrl()
        VCVoiceroidManager.default.saveFileWithCurrentConfig(at: saveUrl)
    }
    func didSayMenuClicked(){
        VCVoiceroidManager.default.sayWithCurrentConfig()
    }
    func didPreferenceMenuClicked(){
        VCPreferenceWindowController.shared.showWindow(nil)
    }
}
