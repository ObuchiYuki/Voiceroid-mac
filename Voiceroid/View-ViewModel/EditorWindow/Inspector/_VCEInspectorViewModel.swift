//
//  _VCEInspectorViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/06.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

protocol _VCEInspectorViewModelBinder:class {
    func registerItemToTableView(nib:NSNib, for identifier:NSUserInterfaceItemIdentifier)
}

class _VCEInspectorViewModel{
    private weak var binder:_VCEInspectorViewModelBinder?
    
    func viewDidLoad(_ binder:_VCEInspectorViewModelBinder){
        self.binder = binder
        
    }
    
    func cellCount() -> Int{
        return cellDataModels.count
    }
    func height(of row:Int) -> CGFloat{
        return 29
    }
    
    func cellIdentifier(for row:Int) -> NSUserInterfaceItemIdentifier{
        switch cellDataModels[row].cellType {
        case .number: return _VCENumberPropertyCell.identifire
        
            
        default:
            <#code#>
        }
    }
    func cellDataType(for row:Int) -> _VCEInspectorCellDataType{
        return .number
    }
}

struct _VCEInspectorCellData {
    enum DataType {
        case number, `enum`, string
    }
    let cellType:DataType
    let data:Any
}

private let cellDataModels = [
    _VCEInspectorCellData(cellType: .string, data: "Hello"),
    _VCEInspectorCellData(cellType: .number, data: 1.0),
    _VCEInspectorCellData(cellType: .number, data: 12.0),
    _VCEInspectorCellData(cellType: .number, data: 1.32),
    _VCEInspectorCellData(cellType: .number, data: 3.14),
]

