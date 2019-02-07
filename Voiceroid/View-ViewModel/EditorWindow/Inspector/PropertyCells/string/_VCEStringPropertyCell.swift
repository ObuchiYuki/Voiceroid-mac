//
//  _VCEStringPropertyCell.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/06.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class _VCEStringPropertyCell: _VCEPropertyCell {
    var text:String{
        set{}
        get{return ""}
    }
}

extension _VCEStringPropertyCell{
    static let nib = NSNib(nibNamed: .init("_VCEStringPropertyCell"), bundle: .main)!
    static let identifier = NSUserInterfaceItemIdentifier(rawValue: "_VCEStringPropertyCell")
}
