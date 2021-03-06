//
//  _VCEPropertyCell.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/07.
//  Copyright © 2019 yuki. All rights reserved.
//

import AppKit

/// PropertyCellの基底クラスです。
/// 初期化後必ずcellIdentifierを指定してください。
/// PropertyCellの派生クラスのViewをXibなどで作る場合は、titleLabelのtagを1にしてください。
class _VCEPropertyCell: NSTableCellView {
    var cellIdentifier:String!
    
    var title:String?{
        get{
            return _getTitleLabel()?.stringValue
        }
        set{
            _getTitleLabel()?.stringValue = newValue ?? ""
        }
    }
    
    private func _getTitleLabel() -> NSTextField?{
        return self.viewWithTag(1) as? NSTextField
    }
}
