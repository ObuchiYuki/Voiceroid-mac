//
//  _VCEditorTextItem.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/04.
//  Copyright © 2019 yuki. All rights reserved.
//

import Cocoa

class _VCEditorTextItem: NSCollectionViewItem {
    func setText(_ text:String){
        self._label.stringValue = text
    }
    var fittingSize:NSSize{
        return self._label.cellSize
    }
    
    @IBOutlet weak private var _label: NSTextFieldCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension NSUserInterfaceItemIdentifier{
    static let _VCEditorTextItemIdentifier = NSUserInterfaceItemIdentifier("_VCEditorTextItemIdentifier")
}
extension NSNib.Name{
    static let _VCEditorTextItemNibName = NSNib.Name(rawValue: "_VCEditorTextItem")
}
