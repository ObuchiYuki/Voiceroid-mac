//
//  VCEInspectorViewContorller.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/05.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCEInspectorViewContorller: NSViewController {
    @IBOutlet weak var tableView:NSTableView!
    
    override func viewDidLoad() {
        self.tableView.register(_VCEEnumPropertyCell.nib, forIdentifier: _VCEEnumPropertyCell.identifire)
        self.tableView.register(_VCENumberPropertyCell.nib, forIdentifier: _VCENumberPropertyCell.identifire)
    }
}

extension VCEInspectorViewContorller: NSTableViewDataSource{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return tableView.makeView(withIdentifier: _VCENumberPropertyCell.identifire, owner: self)
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 29
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 2
    }
}

extension VCEInspectorViewContorller: NSTableViewDelegate{
    
}
