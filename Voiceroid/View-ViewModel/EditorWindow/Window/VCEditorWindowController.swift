//
//  VCEditorWindowController.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/04.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCEditorWindowController: NSWindowController {
    static var shared = NSStoryboard(name: ._editWindow, bundle: .main).instantiateInitialController() as! VCEditorWindowController
}

private extension NSStoryboard.Name{
    static let _editWindow = NSStoryboard.Name("VCEditorWindow")
}
