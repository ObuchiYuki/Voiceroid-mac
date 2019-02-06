//
//  ParamatorViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

/// Bind用
protocol _VCParamatorViewModelBinder:class {
    /// paramatorのSliderの値を変更してください。
    func changeValue(to value:Double,for key:VCConfigParamatorKey)
    /// paramatorのValueLabelの表示を変更してください。
    func changeValueString(to string:String, for key:VCConfigParamatorKey)
    /// VC2感情表現ができるかどうかに応じて、SliderのEnableStateを変更してください。
    func changeEmotionSliderState(to enabled:Bool)
    /// VC2感情表現ができるかどうかに応じて、LabelのTextColorを変更してください。
    func changeEmotionLabelsColor(to color:NSColor)
}

/// Bind用
extension _VCParamatorViewModel{
    /// ViewControllerのviewDidLoadから呼び出してください。
    func viewDidLoad(with binder:_VCParamatorViewModelBinder){
        self.binder = binder
        
        let lastSpeaker = VCApplicationStateSaver.default.getLastSpeaker()
        self._didSpeakerChanged(to: lastSpeaker)
    }
    
    /// Sliderの値が変更されたときに呼び出してください。
    func didValueChange(to value:Double, for paramator:VCConfigParamatorKey){
        VCConfigManager.default.setParamator(value, for: paramator)
        
        let formatedString = _formatDoubleValue(value: value)
        binder?.changeValueString(to: formatedString, for: paramator)
    }
    
    /// リセットボタンが押されたときに呼び出してください。
    func didResetButtonPush(){
        let currentSpeaker = VCConfigManager.default.currentSpeaker()
        VCConfigSaver.default.removeSavedConfig(for: currentSpeaker)
        
        VCConfigManager.default.setSpeaker(currentSpeaker)
    }
}

class _VCParamatorViewModel {
    private weak var binder:_VCParamatorViewModelBinder?
    
    /// 初期化と同時に話者変更の通知を購読します。
    init() {
        NotificationCenter.default.addObserver(forName: .VCConfigManagerSpeakerChanged, object: nil, queue: .main){notice in
            guard let speaker = notice.object as? VCSpeaker else {return}
            self._didSpeakerChanged(to: speaker)
        }
    }
    
    /// 話者変更時に呼び出してください。
    /// Binderを通じてViewに変更を通知します。
    private func _didSpeakerChanged(to speaker:VCSpeaker){
        let config = _loadConfig(for: speaker)
        self._applyConfigToView(with: config)
    }
    
    /// 引数のConfigをBinderを通じてViewに反映させます。
    private func _applyConfigToView(with config:VCConfig){
        binder?.changeEmotionSliderState(to: config.speaker.isvc2)
        binder?.changeEmotionLabelsColor(to: _emotionLabelsColor(for: config.speaker))
        
        for key in VCConfigParamatorKey.allCases{
            binder?.changeValue(to: config.getParamator(for: key), for: key)
            self.didValueChange(to: config.getParamator(for: key), for: key)
        }
    }
    
    /// 引数の話者用のConfigを返します。
    /// 保存とか、デフォルト値とかはVCConfigSaver.default.loadConfig参照。
    private func _loadConfig(for speaker:VCSpeaker) -> VCConfig{
        return VCConfigSaver.default.loadConfig(for: speaker)
    }
    
    /// 話者に応じた感情表現のパラメーターのラベルの色を返します。
    /// 有効なら黒、無効なら灰色です。
    private func _emotionLabelsColor(for speaker:VCSpeaker) -> NSColor{
        let enabledColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        let unenabledColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        if speaker.isvc2{
            return enabledColor
        }else{
            return unenabledColor
        }
    }
    
    /// 0.12121 -> "0.12" です。
    private func _formatDoubleValue(value:Double) -> String{
        return String(format: "%.2f", value)
    }
}
