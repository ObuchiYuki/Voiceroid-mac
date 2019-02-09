//
//  VCEInspectorManager.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/06.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/// InspectorwとEditorViewをつなぎます。
/// ---通知---
/// - VCEInspectorManagerChangeInspectingObject {object:VCConfig}
/// - VCEInspectorManagerChangeConfigValue {object:VCConfig}
class VCEInspectorManager {
    static let `default` = VCEInspectorManager()
    
    func setText(_ text:String){
        _currentInspectingConfig?.text = text
        NotificationCenter.default.post(name: .VCEInspectorManagerChangeConfigValue, object: _currentInspectingConfig)
    }
    func setSpeaker(_ speaker:VCSpeaker){
        _currentInspectingConfig?.speaker = speaker
        NotificationCenter.default.post(name: .VCEInspectorManagerChangeConfigValue, object: _currentInspectingConfig)
    }
    func setParamator(_ value:Double, for key:VCConfigParamatorKey){
        _currentInspectingConfig?.setParamator(value, for: key)
        NotificationCenter.default.post(name: .VCEInspectorManagerChangeConfigValue, object: _currentInspectingConfig)
    }
    func setInspectingConfig(_ config:VCConfig){
        _currentInspectingConfig = config
        NotificationCenter.default.post(name: .VCEInspectorManagerChangeInspectingConfig, object: _currentInspectingConfig)
    }
    private var _currentInspectingConfig:VCConfig? = nil
}


extension Notification.Name{
    static let VCEInspectorManagerChangeInspectingConfig = Notification.Name(rawValue: "VCEInspectorManagerChangeInspectingConfig")
    static let VCEInspectorManagerChangeConfigValue = Notification.Name(rawValue: "VCEInspectorManagerChangeConfigValue")
}
