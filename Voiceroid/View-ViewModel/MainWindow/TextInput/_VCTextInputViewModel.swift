//
//  _VCTextInputViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

protocol _VCTextInputViewModelBinder:class {
    func changeText(to text:String)
}

extension _VCTextInputViewModel{
    func didChangeText(to text:String){
        let trimedString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        
        VCConfigManager.default.setText(trimedString)
    }
    func viewDidLoad(_ binder:_VCTextInputViewModelBinder){
        self.binder = binder
        
    }
}

class _VCTextInputViewModel {
    weak var binder:_VCTextInputViewModelBinder?
    
    init() {
        
    }
}
