//
//  _VCENumberPropertyCell.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/05.
//  Copyright © 2019 yuki. All rights reserved.
//

import Cocoa

/// ----通知----
/// _VCENumberPropertyCellDidChangeValueを投げます。(object: _VCENumberPropertyCell)

class _VCENumberPropertyCell: _VCEPropertyCell {
    @IBOutlet weak var _numberField: NSTextField!
    
    @IBAction func _didNumberChange(_ sender: _VCENumberPropertyCell) {
        NotificationCenter.default.post(name: ._VCENumberPropertyCellDidChangeValue, object: self)
    }
    
    var value:Double{
        set{
            _numberField.stringValue = "\(newValue)"
        }
        get{
            return Double(_numberField.stringValue)!
        }
    }
    var maxValue:Double{
        set{
            
        }
        get{
            return 0
        }
    }
    var minValue:Double{
        set{
            
        }
        get{
            return 0
        }
    }
}

extension Notification.Name{
    static let _VCENumberPropertyCellDidChangeValue = Notification.Name(rawValue: "_VCENumberPropertyCellDidChangeValue")
}

extension _VCENumberPropertyCell{
    static let nib = NSNib(nibNamed: .init("_VCENumberPropertyCell"), bundle: .main)!
    static let identifier = NSUserInterfaceItemIdentifier(rawValue: "_VCENumberPropertyCell")
}
