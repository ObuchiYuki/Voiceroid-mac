//
//  _VCEInspectorCellData.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/07.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/// インスペクターのセルのデータの元となるクラスです。
/// このクラス自体が渡されることはありません。
/// - _VCENumberPropertyCellData
/// - _VCEStringPropertyCellData
/// - _VCEEnumPropertyCellData
/// のいずれかにキャストしてデータを取り出してくだいさい。
class _VCEPropertyCellData {
    enum DataType {
        case number
        case string
        case `enum`
    }
    let cellType:DataType
    let title:String
    
    init(cellType:_VCEPropertyCellData.DataType ,title:String) {
        self.cellType = cellType
        self.title = title
    }
}

class _VCENumberPropertyCellData: _VCEPropertyCellData {
    var value:Double
    var maxValue:Double
    var minValue:Double
    
    init(title:String, value:Double, maxValue:Double, minValue:Double) {
        self.value = value
        self.maxValue = maxValue
        self.minValue = minValue
        
        super.init(cellType: .number, title:title)
    }
}

class _VCEStringPropertyCellData: _VCEPropertyCellData {
    var value:String
    ///`true`にした場合一行での入力になります。
    ///`false`にした場合大きめのスクロール可能なTextViewになります。
    ///デフォルトで`false`です。
    var useSingleLineInput:Bool
    
    init(title:String, value:String, useSingleLineInput:Bool=false) {
        self.value = value
        self.useSingleLineInput = useSingleLineInput
        
        super.init(cellType: .string, title:title)
    }
}

class _VCEEnumPropertyCellData: _VCEPropertyCellData {
    var cases:[String]
    
    init(title:String, cases:[String]) {
        self.cases = cases
        
        super.init(cellType: .enum, title:title)
    }
}

