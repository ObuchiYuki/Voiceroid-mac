//
//  VCPreferenceViewController.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/02.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCPreferenceViewController: NSViewController {
    private let viewModel = _VCPreferenceViewModel()
    
    @IBOutlet private var _fileSelectionMenu:NSPopUpButton!
    
    @IBAction func didSelectMenuClicked(_ sender: Any) {
        viewModel.didSelectMenuClicked()
        VCFileSaveManager.default.showModal{url in
            self.viewModel.didSelectDirectory(to: url)
        }
    }
    
    override func viewDidLoad() {
        viewModel.viewDidLoad(self)
    }
}

extension VCPreferenceViewController: _VCPreferenceViewModelBinder{
    func selectMenuItem(to index: Int) {
        _fileSelectionMenu.selectItem(at: index)
    }
    func changeMenuTitle(to title: String) {
        _fileSelectionMenu.item(at: 0)?.title = title
    }
}
