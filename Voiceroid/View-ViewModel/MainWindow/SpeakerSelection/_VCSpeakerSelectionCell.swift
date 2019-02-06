//
//  _VCSpeakerSelectionCell.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/26.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

/// 話者選択用のセルです。
/// View構成は`_VCSpeakerSelectionCell.xib`で行なっています。
/// イニシャライズは_VCSpeakerSelectionCell::createCell(_:)を使用してください。
class _VCSpeakerSelectionCell: NSTableCellView {
    
    /// Nibからセルのインスタンスを作り返します。
    static func createCell() -> _VCSpeakerSelectionCell?{
        guard let views = NSNib(nibNamed: ._speakerSelectionCell, bundle: .main)?.views(withOwner: self) else {return nil}
        guard let cell = views.first as? _VCSpeakerSelectionCell else {return nil}
        
        return cell
    }
    /// セルにアイコン画像をセットします。
    ///
    /// - Parameter imageName: _VCSpeakerSelectionCellDataModel.imageNameで渡されたimageNameを渡してください。
    func setIcon(for imageName:String){
        self._iconImageView.image = NSImage(named: NSImage.Name(rawValue: imageName))
    }
    
    /// セルに話者名をセットします。日本語で4文字以上を渡すと文字が潰れます。
    ///
    /// - Parameter name: _VCSpeakerSelectionCellDataModel.nameで渡されたimageNameを渡してください。
    func setName(with name:String){
        self._nameLable.stringValue = name
    }
    
    @IBOutlet private var _iconImageView:NSImageView!
    @IBOutlet private var _nameLable:NSTextField!
}

///Nib呼び出しのための拡張
private extension NSNib.Name{
    static let _speakerSelectionCell = NSNib.Name("_VCSpeakerSelectionCell")
}

private extension NSNib {
    func views(withOwner owner: Any?) -> [NSView] {
        var topLevelObjects:NSArray? = []
        guard instantiate(withOwner: owner, topLevelObjects: &topLevelObjects) else {
            return []
        }
        return topLevelObjects?.compactMap{$0 as? NSView} ?? []
    }
}
