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
        return cellDataModels.count
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
        return cellDataModels[row]
    }
    
    func cellIdentifier(for row:Int) -> NSUserInterfaceItemIdentifier{
        switch cellDataType(for: row) {
        case .number: return _VCENumberPropertyCell.identifier
        case .string: return _VCEStringPropertyCell.identifier
        case .enum  : return _VCEEnumPropertyCell.identifier
        }
    }
    func cellDataType(for row:Int) -> _VCEPropertyCellData.DataType{
        return cellDataModels[row].cellType
    }
}


private let cellDataModels:[_VCEPropertyCellData] = [
    _VCEStringPropertyCellData(title: "スクリプト", value: ""),
    _VCEEnumPropertyCellData(title: "話者", cases: [""]),
    _VCENumberPropertyCellData(title: "音量", value: 1.0, maxValue: 0.5, minValue: 2.0),
    _VCENumberPropertyCellData(title: "話速", value: 1.0, maxValue: 0.5, minValue: 2.0),
    _VCENumberPropertyCellData(title: "ピッチ", value: 1.0, maxValue: 0.5, minValue: 2.0),
    _VCENumberPropertyCellData(title: "抑揚", value: 1.0, maxValue: 0.5, minValue: 2.0),
    _VCENumberPropertyCellData(title: "怒り", value: 1.0, maxValue: 0.5, minValue: 2.0),
    _VCENumberPropertyCellData(title: "悲しみ", value: 1.0, maxValue: 0.5, minValue: 2.0),
    _VCENumberPropertyCellData(title: "喜び", value: 1.0, maxValue: 0.5, minValue: 2.0),
]

