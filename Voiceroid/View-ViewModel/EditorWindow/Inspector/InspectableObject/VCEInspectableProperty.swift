//
//  VCEInspectableProperty.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/07.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

protocol VCEInspectable {
    
}

class VCEInspectableProperty<T:VCEInspectable> {
    private var _value:T
    init(value:T) {
        self._value = value
    }
}

extension VCEInspectableProperty{
    func set(_ block:T->Void) -> VCEInspectableProperty<T>{
        return self
    }
    func get(_ block:()->T) -> VCEInspectableProperty<T>{
        return self
    }
}

extension String: VCEInspectable {}
extension Double: VCEInspectable {}
extension Int: VCEInspectable {}
