//
//  _VCEEnumPropertyCell.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/05.
//  Copyright © 2019 yuki. All rights reserved.
//

import Cocoa

class _VCEEnumPropertyCell: NSTableCellView {
    @IBOutlet weak var _popUpButton: NSPopUpButton!
    
    
    @IBAction func PopUpButtonAction(_ sender: Any) {
        print(1827)
    }
    func setItems<T:Equatable>(_ items:[_VCEEnumPropertyCellItem<T>]){
        for item in items{
            self.setItem(item)
        }
    }
    func setItem<T:Equatable>(_ item:_VCEEnumPropertyCellItem<T>){
        _popUpButton.addItem(withTitle: item.name)
    }
}

extension _VCEEnumPropertyCell{
    static let nib = NSNib(nibNamed: .init("_VCEEnumPropertyCell"), bundle: .main)
    static let identifire = NSUserInterfaceItemIdentifier(rawValue: "_VCEEnumPropertyCell")
}

class _VCEEnumPropertyCellItem<T: Equatable> {
    let name:String
    private let object:T
    
    init(name:String, object:T) {
        self.name = name
        self.object = object
    }
}

extension _VCEEnumPropertyCellItem:Equatable{
    static func == (lhs: _VCEEnumPropertyCellItem<T>, rhs: _VCEEnumPropertyCellItem<T>) -> Bool {
        return lhs.object == rhs.object
    }
}
