//
//  _VCEditorTextItem.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/04.
//  Copyright © 2019 yuki. All rights reserved.
//

import Cocoa

class _VCEditorTextItem: NSCollectionViewItem {
    override var title: String?{
        set{_label.stringValue = newValue ?? ""}
        get{return _label.stringValue}
    }
    
    @IBOutlet weak private var _label: NSTextFieldCell!
}

extension NSUserInterfaceItemIdentifier{
    static let _VCEditorTextItemIdentifier = NSUserInterfaceItemIdentifier("_VCEditorTextItemIdentifier")
}
extension NSNib.Name{
    static let _VCEditorTextItemNibName = NSNib.Name(rawValue: "_VCEditorTextItem")
}
