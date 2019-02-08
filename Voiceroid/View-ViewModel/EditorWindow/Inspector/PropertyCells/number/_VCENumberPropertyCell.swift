//
//  _VCENumberPropertyCell.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/05.
//  Copyright © 2019 yuki. All rights reserved.
//

import Cocoa

class _VCENumberPropertyCell: _VCEPropertyCell {
    @IBOutlet weak var _numberField: NSTextField!
    var value:Double{
        set{_numberField.stringValue = "\(newValue)"}
        get{return Double(_numberField.stringValue)!}
    }
    var maxValue:Double{
        set{}
        get{return 0}
    }
    var minValue:Double{
        set{}
        get{return 0}
    }
}

extension _VCENumberPropertyCell{
    static let nib = NSNib(nibNamed: .init("_VCENumberPropertyCell"), bundle: .main)!
    static let identifier = NSUserInterfaceItemIdentifier(rawValue: "_VCENumberPropertyCell")
}
