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
    
    func cellIdentifier(for row:Int) -> NSUserInterfaceItemIdentifier{
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
            self._didCurrentInspectingConfigChange(to: config)
        }
    }
    
    private func _didCurrentInspectingConfigChange(to config:VCConfig){
        self._cellDataModels = [
            _VCEStringPropertyCellData(title: "スクリプト", value: config.text),
            _VCEEnumPropertyCellData(title: "話者", cases: [""]),
            _VCENumberPropertyCellData(title: "音量", value: config.volume, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "話速", value: config.speed, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "ピッチ", value: config.pitch, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "抑揚", value: config.range, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "怒り", value: config.anger, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "悲しみ", value: config.sadness, maxValue: 0.5, minValue: 2.0),
            _VCENumberPropertyCellData(title: "喜び", value: config.joy, maxValue: 0.5, minValue: 2.0),
        ]
        binder?.reloadTableView()
    }
}


