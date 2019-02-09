//
//  _VCEStringPropertyCell.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/06.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class _VCEStringPropertyCell: _VCEPropertyCell {
    @IBOutlet var _textView: NSTextView!

    var text:String{
        set{
            _textView.string = newValue
        }
        get{
            return _textView.string
        }
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        _setup()
    }
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        _setup()
    }
    
    private func _setup(){
        NotificationCenter.default.addObserver(forName: NSTextView.didChangeNotification, object: nil, queue: .main){notice in
            guard let textView = notice.object as? NSTextView else {return}
            VCEInspectorManager.default.setText(textView.string)
        }
    }
}

extension _VCEStringPropertyCell: NSTextViewDelegate{
    override func controlTextDidChange(_ obj: Notification) {
        guard let textView = obj.object as? NSTextView else {return}
        printView(textView.string)
    }
}

extension _VCEStringPropertyCell{
    static let nib = NSNib(nibNamed: .init("_VCEStringPropertyCell"), bundle: .main)!
    static let identifier = NSUserInterfaceItemIdentifier(rawValue: "_VCEStringPropertyCell")
}
