//
//  ParamatorViewController.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

/// 読み上げ設定をするViewです。
/// ロジックは_VCParamatorViewModelの担当です。
class VCParamatorViewController: NSViewController {
    private let viewModel = _VCParamatorViewModel()
    
    @IBOutlet private weak var _volumeSlider: NSSlider!
    @IBOutlet private weak var _speedSlider: NSSlider!
    @IBOutlet private weak var _pitchSlider: NSSlider!
    @IBOutlet private weak var _rangeSlider: NSSlider!
    @IBOutlet private weak var _angerSlider: NSSlider!
    @IBOutlet private weak var _sadnessSlider: NSSlider!
    @IBOutlet private weak var _joySlider: NSSlider!
    
    @IBOutlet private weak var _volumeValueLabel: NSTextField!
    @IBOutlet private weak var _speedValueLable: NSTextField!
    @IBOutlet private weak var _pitchValueLabel: NSTextField!
    @IBOutlet private weak var _rangeValueLable: NSTextField!
    @IBOutlet private weak var _angerValueLabel: NSTextField!
    @IBOutlet private weak var _sadnessValueLable: NSTextField!
    @IBOutlet private weak var _joyValueLabel: NSTextField!
    
    @IBOutlet private weak var _angerLabel: NSTextField!
    @IBOutlet private weak var _sadnessLabel: NSTextField!
    @IBOutlet private weak var _joyLabel: NSTextField!
    
    override func viewDidLoad() {
        viewModel.viewDidLoad(with: self)
    }
    @IBAction private func _volumeSliderDidChange(_ sender: NSSlider) {
        viewModel.didValueChange(to: sender.doubleValue, for: .volume)
    }
    @IBAction private func _speedSliderDidChange(_ sender: NSSlider) {
        viewModel.didValueChange(to: sender.doubleValue, for: .speed)
    }
    @IBAction private func _pitchSliderDidChange(_ sender: NSSlider) {
        viewModel.didValueChange(to: sender.doubleValue, for: .pitch)
    }
    @IBAction private func _rangeSliderDidChange(_ sender: NSSlider) {
        viewModel.didValueChange(to: sender.doubleValue, for: .range)
    }
    @IBAction private func _angerSliderDidChange(_ sender: NSSlider) {
        viewModel.didValueChange(to: sender.doubleValue, for: .anger)
    }
    @IBAction private func _sadnessSliderDidChange(_ sender: NSSlider) {
        viewModel.didValueChange(to: sender.doubleValue, for: .sadness)
    }
    @IBAction private func _joySliderDidChange(_ sender: NSSlider) {
        viewModel.didValueChange(to: sender.doubleValue, for: .joy)
    }
    
    @IBAction func _resetButtonDidPush(_ sender: NSButton) {
        viewModel.didResetButtonPush()
    }
}

extension VCParamatorViewController: _VCParamatorViewModelBinder{
    func changeValue(to value: Double, for key: VCConfigParamatorKey) {
        switch key {
        case .volume: self._volumeSlider.doubleValue = value
        case .speed: self._speedSlider.doubleValue = value
        case .pitch: self._pitchSlider.doubleValue = value
        case .range: self._rangeSlider.doubleValue = value
        case .anger: self._angerSlider.doubleValue = value
        case .sadness: self._sadnessSlider.doubleValue = value
        case .joy: self._joySlider.doubleValue = value
        }
    }
    
    func changeValueString(to string: String, for key: VCConfigParamatorKey) {
        switch key {
        case .volume: self._volumeValueLabel.stringValue = string
        case .speed: self._speedValueLable.stringValue = string
        case .pitch: self._pitchValueLabel.stringValue = string
        case .range: self._rangeValueLable.stringValue = string
        case .anger: self._angerValueLabel.stringValue = string
        case .sadness: self._sadnessValueLable.stringValue = string
        case .joy: self._joyValueLabel.stringValue = string
        }
    }

    func changeEmotionSliderState(to enabled:Bool){
        self._angerSlider.isEnabled = enabled
        self._sadnessSlider.isEnabled = enabled
        self._joySlider.isEnabled = enabled
    }
    
    func changeEmotionLabelsColor(to color: NSColor) {
        self._angerValueLabel.textColor = color
        self._sadnessValueLable.textColor = color
        self._joyValueLabel.textColor = color
        
        self._angerLabel.textColor = color
        self._sadnessLabel.textColor = color
        self._joyLabel.textColor = color
    }
}
