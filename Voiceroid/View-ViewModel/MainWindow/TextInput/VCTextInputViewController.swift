//
//  VCTextInputViewController.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCTextInputViewController: NSViewController {
    private let viewModel = _VCTextInputViewModel()
    @IBOutlet private var _textView: NSTextView!
    
    override func viewDidLoad() {
        viewModel.viewDidLoad(self)
    }
}

extension VCTextInputViewController: NSTextViewDelegate{
    func textDidChange(_ notification: Notification) {
        viewModel.didChangeText(to: _textView.string)
    }
}

extension VCTextInputViewController: _VCTextInputViewModelBinder{
    func changeText(to text: String) {
        _textView.string = text
    }
}
