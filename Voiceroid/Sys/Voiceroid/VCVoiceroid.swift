//
//  NewVoiceroid.swift
//  Voiceroid
//
//  Created by yuki on 2019/01/24.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

/// Voiceroidの最も外側となるクラスです。
/// このクラスはManager層ではなくSys層に存在します。ViewModelからもアクセスしてはいけません。
/// Manager層のクラスのみがこのクラスにアクセス可能です。
class VCVoiceroid{
    
    /// 渡されたコンフィグ内容を読み上げます。
    ///
    /// - Parameters:
    ///   - config: 読み上げる設定
    ///   - completion: 読み上げ完了後コールバックします。
    static func say(config:VCConfig,_ completion:@escaping ()->Void){
        let args = _VCVoiceroidHelper.convertConfigToArguments(config: config)
        DispatchQueue.global().async {
            _VCVoiceroidHelper.executeSayvCommand(with: args)
            completion()
        }
    }
    
    /// 渡されたコンフィグ内容の音声ファイルを保存します。
    ///
    /// - Parameters:
    ///   - config: 音声内容の設定げる設定
    ///   - saveUrl: 保存する場所
    ///   - completion: 保存完了後コールバックします。
    static func saveFile(config:VCConfig, at saveUrl:URL,_ completion:@escaping ()->Void){
        var args = _VCVoiceroidHelper.convertConfigToArguments(config: config)
        args = _VCVoiceroidHelper.saveOptionAppended(to: args, savePath: saveUrl.path)
        DispatchQueue.global().async {
            _VCVoiceroidHelper.executeSayvCommand(with: args)
            completion()
        }
    }
}

private class _VCVoiceroidHelper{
    
    private static let tmpInputFilePath = "/tmp/com.yuki.voiceroid/tmpInputText.txt"
    
    /// 保存用パラメーターを引数に追加します。
    ///
    /// - Parameters:
    ///   - args: 引数リスト _VCVoiceroidHelper::convertConfigToArgumentsで出力されたものです。
    ///   - savePath: 保存する場所のパス。
    /// - Returns: パラメーターが追加された引数。 _VCVoiceroidHelper::executeSayvCommandで実行してください。
    static func saveOptionAppended(to args: [String], savePath:String) -> [String]{
        return args + ["-o", savePath]
    }
    
    /// `VCConfig`をコマンド実行用の引数形式に変換します。
    static func convertConfigToArguments(config:VCConfig) -> [String]{
        _saveTextInputAsTmpFile(for: config.text)
        return [
            // 必須引数
            config.speaker.name, "-i", tmpInputFilePath,
            // 選択可能引数
            "-sp", "\(config.speed)",
            "-p" , "\(config.pitch)",
            "-r" , "\(config.range)",
            "-a" , "\(config.anger)",
            "-s" , "\(config.sadness)",
            "-j" , "\(config.joy)",
        ]
    }
    
    /// bashを使用し**sayv**コマンドを実行します。
    /// 同期的に実行(スレッドを止める)します。
    ///
    /// - Parameter args: コマンドの引数。 _VCVoiceroidHelper::_convertConfigToArgumentsで変換した形式のものを渡してください。
    static func executeSayvCommand(with args:[String]){
        let coomandUrl = FileManager.default.homeDirectoryForCurrentUser.appendingPathComponent("Developer/bin/sayv")
        let task = Process()
        task.launchPath = "/bin/bash"
        task.arguments = [coomandUrl.path] + args
        task.launch()
        task.waitUntilExit()
    }
    
    /// コマンドではスペースが入ると時たま壊れるので、外部ファイルから読み込む用。
    private static func _saveTextInputAsTmpFile(for text:String){
        FileManager.default.createFile(atPath: tmpInputFilePath, contents: text.data(using: .utf8))
    }
}
