//
//  VCSpeakerSelectVewController.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/25.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

/// 話者を選ぶびビューを管理します。
/// ロジックは_VCSpeakerSelectionViewModelが担当しています。
class VCSpeakerSelectionViewController: NSViewController {
    private let viewModel = _VCSpeakerSelectionViewModel()
    
    @IBOutlet private weak var _tableView: NSTableView!
    
    override func viewDidLoad() {
        viewModel.viewDidLoad(with: self)
    }
}

extension VCSpeakerSelectionViewController: _VCSpeakerSelectionViewModelBinder{
    func selectRow(with rowNumber: Int) {
        self._tableView.selectRowIndexes(IndexSet(integer: rowNumber), byExtendingSelection: false)
    }
}

/// TableView周りの設定
extension VCSpeakerSelectionViewController: NSTableViewDataSource, NSTableViewDelegate{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return viewModel.cellHeight(of: row)
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let cellData = viewModel.cellData(for: row) else {return nil}
        guard let cell = _VCSpeakerSelectionCell.createCell() else {return nil}
        
        cell.setIcon(for: cellData.imageName)
        cell.setName(with: cellData.name)
        
        return cell
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        viewModel.didSelect(at: _tableView.selectedRow)
    }
}

