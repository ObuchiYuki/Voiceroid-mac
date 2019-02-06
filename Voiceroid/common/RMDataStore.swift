//
//  RMDataStore.swift
//  Voiceroid
//
//  Created by yuki on 2019/02/01.
//  Copyright © 2019 yuki. All rights reserved.
//

import Foundation

typealias RMStorable = Codable

class RMStorage{
    static let shared = RMStorage()
    
    func store<T: RMStorable>(_ value:T, for key: RMStorage.Name<T>){
        guard let data = try? PropertyListEncoder().encode(value) else {return}
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }
    
    func get<T: RMStorable>(for key: RMStorage.Name<T>) -> T?{
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {return nil}
        return try? PropertyListDecoder().decode(T.self, from: data)
    }
    
    @discardableResult
    func remove<T: RMStorable>(with key:RMStorage.Name<T>) -> T?{
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else {return nil}
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        
        return try? PropertyListDecoder().decode(T.self, from: data)
    }
}

struct RMWrapper<Value>{
    var raw:Value{
        return self.rawValue
    }
    private let rawValue:Value
    init(_ rawValue:Value) {
        self.rawValue = rawValue
    }
}

extension RMWrapper: Codable where Value: Codable {}

extension RMStorage {
    struct Name <Value: RMStorable> {
        fileprivate let rawValue:String
        
        init(rawValue: String){
            self.rawValue = rawValue
        }
    }
}
