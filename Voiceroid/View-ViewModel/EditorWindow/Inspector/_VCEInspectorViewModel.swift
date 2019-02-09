//
//  _VCEInspectorViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/06.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

protocol _VCEInspectorViewModelBinder:class {
    func registerNibToTableView(nib:NSNib, for identifier:NSUserInterfaceItemIdentifier)
    func reloadTableView()
}

class _VCEInspectorViewModel{
    private weak var binder:_VCEInspectorViewModelBinder?
    
    func viewDidLoad(_ binder:_VCEInspectorViewModelBinder){
        self.binder = binder
        
        binder.registerNibToTableView(nib: _VCENumberPropertyCell.nib, for: _VCENumberPropertyCell.identifier)
        binder.registerNibToTableView(nib: _VCEStringPropertyCell.nib, for: _VCEStringPropertyCell.identifier)
        binder.registerNibToTableView(nib: _VCEEnumPropertyCell.nib, for: _VCEEnumPropertyCell.identifier)
    }
    
    func cellCount() -> Int{
        return _cellDataModels.count
    }
    func height(of row:Int) -> CGFloat{
        switch cellDataType(for: row) {
        case .number, .enum:
            return 29
        case .string:
            return 125
        }
    }
    
    func cellData(for row:Int) -> _VCEPropertyCellData {
        return _cellDataModels[row]
    }
    
    func cellIdentifier(for row:Int) -> String{
        return _cellDataModels[row].cellIdentifier
    }
    func cellTypeIdentifier(for row:Int) -> NSUserInterfaceItemIdentifier{
        switch cellDataType(for: row) {
        case .number: return _VCENumberPropertyCell.identifier
        case .string: return _VCEStringPropertyCell.identifier
        case .enum  : return _VCEEnumPropertyCell.identifier
        }
    }
    
    func cellDataType(for row:Int) -> _VCEPropertyCellData.DataType{
        return _cellDataModels[row].cellType
    }
    
    private var _cellDataModels:[_VCEPropertyCellData] = []
    
    init() {
        NotificationCenter.default.addObserver(forName: .VCEInspectorManagerChangeInspectingConfig, object: nil, queue: .main){notice in
            guard let config = notice.object as? VCConfig else {return}
            
            self._didCurrentInspectingConfigChanged(to: config)
        }
        
        NotificationCenter.default.addObserver(forName: ._VCENumberPropertyCellDidChangeValue, object: nil, queue: .main){notice in
            guard let cell = notice.object as? _VCENumberPropertyCell else {return}
            
            self._didInspectingNumberPropertyChanged(to: cell.value, for: cell.cellIdentifier)
        }
    }
    private func _didInspectingNumberPropertyChanged(to value:Double, for cellIdentifier:String){
        guard let configKey = _convertCellIdentifierToConfigKey(cellIdentifier) else {return}
        
        VCEInspectorManager.default.setParamator(value, for: configKey)
    }
    private func _didCurrentInspectingConfigChanged(to config:VCConfig){
        self._cellDataModels = [
            _VCEStringPropertyCellData(title: "スクリプト", identifier:"vce.title", value: config.text),
            _VCEEnumPropertyCellData  (title: "話者",   identifier:"vce.speaker", cases: [""]),
            _VCENumberPropertyCellData(title: "音量",   identifier:VCConfigParamatorKey.volume.rawValue, value: config.volume, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "話速",   identifier:VCConfigParamatorKey.speed.rawValue, value: config.speed, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "ピッチ",  identifier:VCConfigParamatorKey.pitch.rawValue, value: config.pitch, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "抑揚",   identifier:VCConfigParamatorKey.range.rawValue, value: config.range, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "怒り",   identifier:VCConfigParamatorKey.anger.rawValue, value: config.anger, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "悲しみ",  identifier:VCConfigParamatorKey.sadness.rawValue, value: config.sadness, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "喜び",   identifier:VCConfigParamatorKey.joy.rawValue, value: config.joy, maxValue: 0.5, minValue: 2.0),
        ]
        binder?.reloadTableView()
    }
    private func _convertConfigKeyToCellIdentifier(_ configKey:VCConfigParamatorKey) -> String{
        return configKey.rawValue
    }
    private func _convertCellIdentifierToConfigKey(_ cellIdentifier:String) -> VCConfigParamatorKey?{
        return VCConfigParamatorKey(rawValue: cellIdentifier)
    }
}


