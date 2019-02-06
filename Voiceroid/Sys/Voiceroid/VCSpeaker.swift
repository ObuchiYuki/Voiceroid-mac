//
//  VCSpeaker.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/24.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/**
 Voiceroidの話者定義用Enumです。
 ### Usage
 定義済み話者として
 - yukari(*)
 - maki
 - aoi(*)
 - akane(*)
 - zunko
 - kiritan
 - itako
 - yoshida
 - akari(*)
 - kou
 - haruno
 
 を持ちます。(*)がついているのはVC2感情表現対応です。
 */
enum VCSpeaker:Int{
    case yukari = 0
    case maki
    case aoi
    case akane
    case zunko
    case kiritan
    case yoshida
    case akari
    case kou
    case haruno
    case itako
    
    var name:String{
        switch self {
        case .yukari:   return "YUKARI"
        case .maki: return "MAKI"
        case .aoi:  return "AOI"
        case .akane:    return "AKANE"
        case .zunko:    return "ZUNKO"
        case .kiritan:  return "KIRITAN"
        case .yoshida:  return "YOSHIDA"
        case .akari:    return "AKARI"
        case .kou:  return "KOU"
        case .haruno:   return "HARUNO"
        case .itako:    return "ITAKO"
        }
    }
    var isvc2:Bool{
        switch self {
        case .yukari:   return true
        case .maki: return false
        case .aoi:  return true
        case .akane:    return true
        case .zunko:    return false
        case .kiritan:  return false
        case .yoshida:  return false
        case .akari:    return true
        case .kou:  return false
        case .haruno:   return false
        case .itako:    return false
        }
    }
}

extension VCSpeaker: RMStorable {}
