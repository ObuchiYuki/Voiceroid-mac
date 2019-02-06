//
//  _MainWindowViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

/// _MainWindowViewModelが投げる通知を受け取るためのプロトコルです。
protocol _VCMainWindowViewModelDelegate: class {
    func changeTitle(to title:String)
    func changePlayableState(to enabled:Bool)
    func changeProgressState(to progressing:Bool)
}

extension _VCMainWindowViewModel{
    func windowDidLoad(with delegate:_VCMainWindowViewModelDelegate) {
        self.delagete = delegate
        let lastSpeaker = VCApplicationStateSaver.default.getLastSpeaker()
        self._speakerDidChanged(to: lastSpeaker)
        self._configDidChange(to: VCConfigManager.default.createConfig())
    }
    
    func sayButtonDidPush(){
        VCVoiceroidManager.default.sayWithCurrentConfig()
    }
    func saveButtonDidPush(){
        let saveUrl = VCFileSaveManager.default.saveUrl()
        VCVoiceroidManager.default.saveFileWithCurrentConfig(at: saveUrl)
    }
    func editButtonDidPush(){
        VCEditorWindowController.shared.showWindow(nil)
    }
}

/// MainWindowのロジックを担当します。
class _VCMainWindowViewModel {
    weak var delagete:_VCMainWindowViewModelDelegate?
    
    init() {
        NotificationCenter.default.addObserver(forName: .VCConfigManagerSpeakerChanged, object: nil, queue: .main){notice in
            guard let speaker = notice.object as? VCSpeaker else {return}
            self._speakerDidChanged(to: speaker)
        }
        NotificationCenter.default.addObserver(forName: .VCConfigManagerConfigChanged, object: nil, queue: .main){notice in
            guard let config = notice.object as? VCConfig else {return}
            self._configDidChange(to: config)
        }
        NotificationCenter.default.addObserver(forName: .VCVoiceroidManagerStartProcesssing, object: nil, queue: .main){notice in
            self.delagete?.changeProgressState(to: true)
        }
        NotificationCenter.default.addObserver(forName: .VCVoiceroidManagerEndProcesssing, object: nil, queue: .main){notice in
            self.delagete?.changeProgressState(to: false)
        }
    }
    
    private func _configDidChange(to config:VCConfig){
        let enabled = self._canExcuteVoiceroid(with: config)
        delagete?.changePlayableState(to: enabled)
    }
    private func _speakerDidChanged(to speaker:VCSpeaker){
        let speakerName = self._locarizedName(for: speaker)
        self.delagete?.changeTitle(to: speakerName)
    }
    private func _canExcuteVoiceroid(with config:VCConfig) -> Bool{
        if config.text.isEmpty{
            return false
        }
        return true
    }
    private func _locarizedName(for speaker:VCSpeaker) -> String{
        switch speaker {
        case .yukari:  return "結月ゆかり"
        case .maki:    return "弦巻マキ"
        case .aoi:     return "琴葉 茜"
        case .akane:   return "琴葉 葵"
        case .zunko:   return "東北ずん子"
        case .kiritan: return "東北きりたん"
        case .itako:   return "東北イタコ"
        case .yoshida: return "鷹の爪 吉田くん"
        case .akari:   return "紲星あかり"
        case .kou:     return "水奈瀬コウ"
        case .haruno:  return "桜乃そら"
        default:       fatalError("Speaker: \(speaker.name) is not defined.")
        }
    }
}
