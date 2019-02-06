//
//  VCMainMenu.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCMainMenu:NSObject {
    private let viewModel = _VCMainMenuModel()
    
    @IBOutlet weak private var _saveMenu: NSMenuItem!
    
    @IBAction func didSaveMenuClicked(_ sender: NSMenuItem) {
        viewModel.didSaveMenuClicked()
    }
    @IBAction func didSayMenuClicked(_ sender: NSMenuItem) {
        viewModel.didSayMenuClicked()
    }
    @IBAction func didPreferenceMenuClicked(_ sender: NSMenuItem) {
        viewModel.didPreferenceMenuClicked()
    }
    
    override init() {
        super.init()
        
        viewModel.binder = self
    }
}

extension VCMainMenu: _VCMainMenuModelBinder{
    func changeSaveMenuState(_ enabled: Bool) {
        _saveMenu.isEnabled = enabled
    }
}
