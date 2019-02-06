//
//  _VCSpeakerSelectionViewModel.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

protocol _VCSpeakerSelectionViewModelBinder :class{
    func selectRow(with rowNumber:Int)
}

/// 呼び出し
extension _VCSpeakerSelectionViewModel{
    func viewDidLoad(with binder:_VCSpeakerSelectionViewModelBinder){
        self.binder = binder
        let lastSpeaker = VCApplicationStateSaver.default.getLastSpeaker()
        let lastSelectedRowNumber = self._rowNumber(for: lastSpeaker)
        
        binder.selectRow(with: lastSelectedRowNumber)
    }
    
    ///話者が選択された時呼び出してください。
    func didSelect(at row:Int){
        guard _dataModels.indices.contains(row) else {return}
        let speaker = _dataModels[row].speaker
        VCConfigManager.default.setSpeaker(speaker)
    }
}

/// 読み出し
extension _VCSpeakerSelectionViewModel{
    /// 各行におけるセルの高さです。
    func cellHeight(of row:Int) -> CGFloat{
        return 58
    }
    /// セルの数です。
    func numberOfRows() -> Int{
        return _dataModels.count
    }
    /// 各行におけるセルのデータです。
    /// Returns: _VCSpeakerSelectionCellDataModelのインスタンスです。
    func cellData(for row:Int) -> _VCSpeakerSelectionCellDataModel?{
        guard _dataModels.indices.contains(row) else {return nil}
        return _dataModels[row]
    }
}

/// VCSpeakerSelectionViewControllerに画面構成に必要な情報を渡します。
class _VCSpeakerSelectionViewModel {
    private weak var binder:_VCSpeakerSelectionViewModelBinder?
    
    private func _rowNumber(for speaker:VCSpeaker) -> Int{
        return self._dataModels.enumerated().first{$0.element.speaker == speaker}?.offset ?? 0
    }
    /// データモデルのリストです。
    private let _dataModels:[_VCSpeakerSelectionCellDataModel] = [
        _VCSpeakerSelectionCellDataModel(name: "ゆかり",imageName: "VC_S_yukari_icon", speaker: .yukari),
        _VCSpeakerSelectionCellDataModel(name: "マキ",imageName: "VC_S_maki_icon", speaker: .maki),
        _VCSpeakerSelectionCellDataModel(name: "琴葉茜",imageName: "VC_S_akane_icon", speaker: .akane),
        _VCSpeakerSelectionCellDataModel(name: "琴葉葵",imageName: "VC_S_aoi_icon", speaker: .aoi),
        _VCSpeakerSelectionCellDataModel(name: "ずん子",imageName: "VC_S_zunko_icon", speaker: .zunko),
        _VCSpeakerSelectionCellDataModel(name: "きりたん",imageName: "VC_S_kiritan_icon", speaker: .kiritan),
        _VCSpeakerSelectionCellDataModel(name: "いたこ",imageName: "VC_S_itako_icon",speaker: .itako),
        _VCSpeakerSelectionCellDataModel(name: "あかり",imageName: "VC_S_akari_icon",speaker: .akari),
        _VCSpeakerSelectionCellDataModel(name: "吉田",imageName: "VC_S_yoshida_icon",speaker: .yoshida),
        _VCSpeakerSelectionCellDataModel(name: "コウ",imageName: "VC_S_kou_icon",speaker: .kou),
        _VCSpeakerSelectionCellDataModel(name: "桜乃",imageName: "VC_S_sora_icon",speaker: .haruno),
    ]
}

/// セルのデータモデルです。
struct _VCSpeakerSelectionCellDataModel {
    let name:String
    let imageName:String
    
    fileprivate let speaker:VCSpeaker
}
