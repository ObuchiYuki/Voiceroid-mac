//
//  VCApplicationStateSaver.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/27.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

class VCApplicationStateSaver {
    static let `default` = VCApplicationStateSaver()
    
    /// アプリの最後に使用していた話者を返します。
    /// 存在しなかった場合は、.yukairを返します。
    func getLastSpeaker() -> VCSpeaker{
        if let speaker = RMStorage.shared.get(for: ._lastSpeakerKey){
            return speaker
        }
        return .yukari
    }

    ///初期化します。AppDelegateから呼び出してください。
    func initialize(){
        NotificationCenter.default.addObserver(forName: .VCConfigManagerSpeakerChanged, object: nil, queue: .main){notice in
            guard let speaker = notice.object as? VCSpeaker else {return}
            self._didSpeakerChanged(to: speaker)
        }
    }
    
    private func _didSpeakerChanged(to speaker:VCSpeaker){
        RMStorage.shared.store(speaker, for: ._lastSpeakerKey)
    }
}

private extension RMStorage.Key{
    static var _lastSpeakerKey:RMStorage.Key<VCSpeaker> {
        return RMStorage.Key(rawValue: "VCApplicationStateSaver._lastSpeakerKey")
    }
}

extension RMStorage.Key{
    static var _saveURLKey:RMStorage.Key<URL> {
        return RMStorage.Key(rawValue: "VCApplicationStateSaver._saveURLKey")
    }
}
