//
//  MainWindowController.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

/// メインウィンドウを管理します。タブバーの管理もここです。
/// ロジックは_MainWindowViewModelがやります。
class VCMainWindowController:NSWindowController {
    private let viewModel = _VCMainWindowViewModel()
    
    @IBOutlet weak var toolBarPlayButton: NSButton!
    @IBOutlet weak var toolBarSaveButton: NSButton!
    @IBOutlet weak var toolBarEditButton: NSButton!
    
    @IBAction func _saveButtonDidPush(_ sender: NSButton) {
        viewModel.saveButtonDidPush()
    }
    @IBAction func _sayButtonDidPush(_ sender: NSButton) {
        viewModel.sayButtonDidPush()
    }
    @IBAction func editButtonDidPush(_ sender: NSButton) {
        viewModel.editButtonDidPush()
    }
    
    override func windowDidLoad() {
        viewModel.windowDidLoad(with: self)
    }
}

extension VCMainWindowController: _VCMainWindowViewModelDelegate{
    func changeTitle(to title: String) {
        self.window?.title = title
    }
    func changePlayableState(to enabled: Bool) {
        toolBarPlayButton.isEnabled = enabled
        toolBarSaveButton.isEnabled = enabled
        //toolBarEditButton.isEnabled = enabled
    }
    func changeProgressState(to progressing: Bool) {
        
    }
}
