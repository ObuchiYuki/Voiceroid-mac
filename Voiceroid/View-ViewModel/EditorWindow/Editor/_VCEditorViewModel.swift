//
//  _VCEditorViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/08.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

class _VCEditorViewModel {
    func didSelectRow(at index:Int){
        print(index)
        VCEInspectorManager.default.currentInspectingConfig = sampleTexts[index].config
    }
    func itemSize(for row:Int) -> NSSize{
        let string = sampleTexts[row].title
        let size = NSTextField(labelWithString: string).sizeThatFits(NSSize(width: 400, height: 800))
        return size
    }
    func itemCount() -> Int{
        return sampleTexts.count
    }
    func itemData(for row:Int) -> _VCEditorViewTextItemData{
        return sampleTexts[row]
    }
}

struct _VCEditorViewTextItemData {
    let title:String
    let config:VCConfig
}


let sampleTexts = [
    _VCEditorViewTextItemData(title: "コールドウォレットとは。", config:VCConfig(text: "コールドウォレットとは。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "仮想通貨をインターネットに接続しない", config:VCConfig(text: "仮想通貨をインターネットに接続しない", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "物理デバイスで保管するもの。", config:VCConfig(text: "物理デバイスで保管するもの。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "コールドウォレットを使うことで。", config:VCConfig(text: "コールドウォレットを使うことで。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "仮想通貨はオフラインのデバイスを", config:VCConfig(text: "仮想通貨はオフラインのデバイスを", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "持つ本人にしか管理できず。", config:VCConfig(text: "持つ本人にしか管理できず。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "ハッキングやセキュリティ侵害に", config:VCConfig(text: "ハッキングやセキュリティ侵害に", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "脅かされる心配もほとんどありません。", config:VCConfig(text: "脅かされる心配もほとんどありません。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "しかし。", config:VCConfig(text: "しかし。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "Cotton氏が亡くなったことで。", config:VCConfig(text: "Cotton氏が亡くなったことで。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "そのコールドウォレットがどんなものでどこに存在して。", config:VCConfig(text: "そのコールドウォレットがどんなものでどこに存在して。", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "どれだけの額を", config:VCConfig(text: "どれだけの額を", speaker: .yukari)),
    _VCEditorViewTextItemData(title: "保管しているのかがわからないままになってしまったそうです。", config:VCConfig(text: "保管しているのかがわからないままになってしまったそうです。", speaker: .yukari)),
]
