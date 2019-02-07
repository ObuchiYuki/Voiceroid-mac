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
    func registerNibToTableView(nib: NSNib, for identifier: NSUserInterfaceItemIdentifier) {
        self.tableView.register(nib, forIdentifier: identifier)
    }
}

extension VCEInspectorViewContorller: NSTableViewDataSource{
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let identifier = viewModel.cellIdentifier(for: row)
        let data = viewModel.cellData(for: row)
        guard let cell = tableView.makeView(withIdentifier: identifier, owner: self) as? _VCEPropertyCell else {return nil}
        
        cell.title = data.title
        
        
        switch viewModel.cellDataType(for: row) {
        case .string:
            guard let data = data as? _VCEStringPropertyCellData else {return nil}
            guard let cell = cell as? _VCEStringPropertyCell else {return nil}
            cell.text = data.value
            
        case .number:
            guard let data = data as? _VCENumberPropertyCellData else {return nil}
            guard let cell = cell as? _VCENumberPropertyCell else {return nil}
            cell.value = data.value
            cell.maxValue = data.maxValue
            cell.minValue = data.minValue
            
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return viewModel.height(of: row)
    }
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.cellCount()
    }
}

extension VCEInspectorViewContorller: NSTableViewDelegate{
    
}
