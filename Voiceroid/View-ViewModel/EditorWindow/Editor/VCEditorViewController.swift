//
//  VCEditorViewController.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/04.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

let sampleTexts = ["コールドウォレットとは。", "仮想通貨をインターネットに接続しない", "物理デバイスで保管するもの。", "コールドウォレットを使うことで。", "仮想通貨はオフラインのデバイスを","持つ本人にしか管理できず。", "ハッキングやセキュリティ侵害に", "脅かされる心配もほとんどありません。", "しかし。", "Cotton氏が亡くなったことで。", "そのコールドウォレットがどんなものでどこに存在して。", "どれだけの額を","保管しているのかがわからないままになってしまったそうです。"]

class VCEditorViewController: NSViewController {
    @IBOutlet weak var collectionView:NSCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = NSNib(nibNamed: ._VCEditorTextItemNibName, bundle: .main)
        collectionView.register(nib, forItemWithIdentifier: ._VCEditorTextItemIdentifier)
    }
}

extension VCEditorViewController: NSCollectionViewDataSource{
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: ._VCEditorTextItemIdentifier, for: indexPath) as! _VCEditorTextItem
        let data = sampleTexts[indexPath.item]
        item.setText(data)
        
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return sampleTexts.count
    }
    
}
extension VCEditorViewController: NSCollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: NSCollectionView, layout: NSCollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> NSSize{
        
        let string = sampleTexts[indexPath.item]
        let size = NSTextField(labelWithString: string).sizeThatFits(NSSize(width: 400, height: 800))
        print(size)
        return size
        
    }
}

