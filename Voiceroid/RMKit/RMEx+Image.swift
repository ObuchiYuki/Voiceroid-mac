//
//  RMImage+Ex.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/09.
//  Copyright © 2019 yuki. All rights reserved.
//
#if os(macOS)
    import Cocoa
    private typealias RMImage = NSImage
#elseif os(iOS)
    import UIKit
    private typealias RMImage = UIImage
#endif

