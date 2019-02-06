//
//  VCConfig.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/24.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 Voiceroidの設定をしまう箱です。
 VC2でなければ設定できない値についてはPython側でハンドリングします。
 */
struct VCConfig{
    /// **注意!!**
    ///` VCConfig::text`は空白の状態で`VCVoiceroid`に渡すと実行時エラーで落ちます。
    var text:String
    var speaker:VCSpeaker
    var volume:Double
    var speed:Double
    var pitch:Double
    var range:Double
    var anger:Double
    var sadness:Double
    var joy:Double
    
    init(
        text:String, speaker:VCSpeaker, volume:Double=1, speed:Double=1, pitch:Double=1,
        range:Double=1, anger:Double=0, sadness:Double=0, joy:Double=0){
        self.text = text
        self.speaker = speaker
        self.volume = volume
        self.speed = speed
        self.pitch = pitch
        self.range = range
        self.anger = anger
        self.sadness = sadness
        self.joy = joy
    }
}

extension VCConfig{
    /// コンフィグの指定したパラメーターの値を返します。
    func getParamator(for key: VCConfigParamatorKey) -> Double{
        switch key {
        case .volume: return self.volume
        case .speed: return self.speed
        case .pitch: return self.pitch
        case .range: return self.range
        case .anger: return self.anger
        case .sadness: return self.sadness
        case .joy: return self.joy
        }
    }
    /// コンフィグに指定したパラメーターの値をセットします。
    mutating func setParamator(_ value:Double, for key: VCConfigParamatorKey){
        switch key {
        case .volume: self.volume = value
        case .speed: self.speed = value
        case .pitch: self.pitch = value
        case .range: self.range = value
        case .anger: self.anger = value
        case .sadness: self.sadness = value
        case .joy: self.joy = value
        }
    }
}

extension VCConfig: RMStorable {}

/// コンフィグの内容のenumです。全て中身はDoubleです。
/// ほら、数多いし...
enum VCConfigParamatorKey:CaseIterable {
    case volume
    case speed
    case pitch
    case range
    case anger
    case sadness
    case joy
}

