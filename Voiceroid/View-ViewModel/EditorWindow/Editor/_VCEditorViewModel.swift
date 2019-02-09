//
//  _VCEditorViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/08.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit


protocol _VCEditorViewModelBinder:class {
    func reloadItem(at index:Int)
}
class _VCEditorViewModel {
    private weak var binder:_VCEditorViewModelBinder?
    private var _selectedRowIndex:Int?
    
    func viewDidLoad(_ binder:_VCEditorViewModelBinder){
        self.binder = binder
    }
    
    func didSelectRow(at index:Int){
        _selectedRowIndex = index
        VCEInspectorManager.default.setInspectingConfig(sampleTexts[index].config)
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
    
    init() {
        NotificationCenter.default.addObserver(forName: .VCEInspectorManagerChangeConfigValue, object: nil, queue: .main){notice in
            guard let config = notice.object as? VCConfig else {return}
            self._didInspectingConfigValueChange(to: config)
        }
    }
    
    private func _didInspectingConfigValueChange(to config:VCConfig){
        guard let selectedRowIndex = self._selectedRowIndex else {return}
        
        sampleTexts[selectedRowIndex].config = config
        print(sampleTexts[selectedRowIndex])
        binder?.reloadItem(at: selectedRowIndex)
    }
}

struct _VCEditorViewTextItemData {
    var title:String{
        return self.config.text
    }
    var config:VCConfig
}


var sampleTexts = [
    _VCEditorViewTextItemData(config:VCConfig(text: "コールドウォレットとは。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "仮想通貨をインターネットに接続しない", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "物理デバイスで保管するもの。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "コールドウォレットを使うことで。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "仮想通貨はオフラインのデバイスを", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "持つ本人にしか管理できず。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "ハッキングやセキュリティ侵害に", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "脅かされる心配もほとんどありません。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "しかし。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "Cotton氏が亡くなったことで。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "そのコールドウォレットがどんなものでどこに存在して。", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "どれだけの額を", speaker: .yukari)),
    _VCEditorViewTextItemData(config:VCConfig(text: "保管しているのかがわからないままになってしまったそうです。", speaker: .yukari)),
]
