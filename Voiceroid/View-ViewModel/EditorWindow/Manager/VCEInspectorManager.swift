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
class VCEInspectorManager {
    static let `default` = VCEInspectorManager()
    
    var currentInspectingConfig:VCConfig? = nil{
        didSet{
            NotificationCenter.default.post(name: .VCEInspectorManagerChangeInspectingConfig, object: currentInspectingConfig)
        }
    }
}


extension Notification.Name{
    static let VCEInspectorManagerChangeInspectingConfig = Notification.Name(rawValue: "VCEInspectorManagerChangeInspectingConfig")
}
