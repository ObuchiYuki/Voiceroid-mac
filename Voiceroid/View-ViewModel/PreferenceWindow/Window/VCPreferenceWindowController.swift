//
//  PreferenceWindowController.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/29.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCPreferenceWindowController: NSWindowController {
    static var shared = NSStoryboard(name: ._preferenceWindow, bundle: .main).instantiateInitialController() as! VCPreferenceWindowController
}

private extension NSStoryboard.Name{
    static let _preferenceWindow = NSStoryboard.Name("VCPreferenceWindow")
}
