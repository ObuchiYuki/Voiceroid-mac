//
//  VCEInspectorViewContorller.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/05.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCEInspectorViewContorller: NSViewController {
    @IBOutlet private weak var tableView:NSTableView!
    private let viewModel = _VCEInspectorViewModel()
    
    override func viewDidLoad() {
        viewModel.viewDidLoad(self)
    }
}

extension VCEInspectorViewContorller: _VCEInspectorViewModelBinder{
    func registerItemToTableView(nib: NSNib, for identifier: NSUserInterfaceItemIdentifier) {
        self.tableView.register(nib, forIdentifier: identifier)
    }
}


extension VCEInspectorViewContorller: NSTableViewDataSource{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: viewModel.cellIdentifier(for: row), owner: self)
        switch viewModel.cellDataType(for: row) {
        case .number:
            break
            //...
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return viewModel.height(of: row)
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 2
    }
}

extension VCEInspectorViewContorller: NSTableViewDelegate{
    
}
