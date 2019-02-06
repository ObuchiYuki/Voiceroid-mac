//
//  _VCPreferenceViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/29.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

protocol _VCPreferenceViewModelBinder:class {
    func selectMenuItem(to index: Int)
    func changeMenuTitle(to title:String)
}

class _VCPreferenceViewModel {
    private weak var binder:_VCPreferenceViewModelBinder?
    
    func didSelectMenuClicked(){
        binder?.selectMenuItem(to: 0)
    }
    func didSelectDirectory(to url:URL){
        VCFileSaveManager.default.setSaveUrl(url)
        _didUrlChange(to: url)
    }
    private func _didUrlChange(to url:URL){
        let title = url.lastPathComponent 
        binder?.changeMenuTitle(to: title)
    }
    func viewDidLoad(_ binder:_VCPreferenceViewModelBinder){
        self.binder = binder
        let lastUrl = VCFileSaveManager.default.saveDirectory()
        
        _didUrlChange(to: lastUrl)
    }
}
