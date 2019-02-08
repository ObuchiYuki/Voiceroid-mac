//
//  VCEditorViewController.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/04.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class VCEditorViewController: NSViewController {
    @IBOutlet weak var collectionView:NSCollectionView!
    private let viewModel = _VCEditorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = NSNib(nibNamed: ._VCEditorTextItemNibName, bundle: .main)
        collectionView.register(nib, forItemWithIdentifier: ._VCEditorTextItemIdentifier)
    }
}

extension VCEditorViewController: NSCollectionViewDataSource, NSCollectionViewDelegate, NSCollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: ._VCEditorTextItemIdentifier, for: indexPath) as! _VCEditorTextItem
        let data = viewModel.itemData(for: indexPath.item)
        item.title = data.title
        
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.itemCount()
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        if let row = indexPaths.first?.item{
            viewModel.didSelectRow(at: row)
        }
    }
    
    func collectionView(_ collectionView: NSCollectionView, layout: NSCollectionViewLayout, sizeForItemAt index: IndexPath) -> NSSize{
        return viewModel.itemSize(for: index.item)
    }
}

