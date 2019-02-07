//
//  VCEConfigWrapper.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/07.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation


class VCEConfigWrapper: VCEInspectableObject {
    private var _config:VCConfig
    
    init(config:VCConfig) {
        self._config = config
        super.init()
    }
    
    var text:String{
        get{return _config.text}
        set{self._config.text = newValue}
    }
}
