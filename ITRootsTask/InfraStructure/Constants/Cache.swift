//
//  Cache.swift
//  Maintenance
//
//  Created by Ann Mohammed on 02/12/2023.
//

import Foundation

final class Cache {
    
    private static func archiveUserInfo(info : Any) -> Data {
        return try! NSKeyedArchiver.archivedData(withRootObject: info, requiringSecureCoding: false)
    }
    
    static func object<T: Decodable>(of type: T.Type, key: String) -> T? {
        if let objectData = UserDefaults.standard.object(forKey: key) as? Data {
            if let object = try? JSONDecoder().decode(T.self, from: objectData) {
                return object
            }
        }
        if let unarchivedObject: Data = UserDefaults.standard.object(forKey: key) as? Data{
            return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedObject) as! T?
        }
        return nil
    }
    
    static func set<T: Encodable>(object : T, forKey key: String) {
        if let objectData = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(objectData, forKey: key)
        } else {
            let archivedObject = archiveUserInfo(info: object)
            UserDefaults.standard.set(archivedObject, forKey: key)
        }
        UserDefaults.standard.synchronize()
    }
    
    static func removeObject(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func logout() {
        removeObject(key: Keys.currentUser.rawValue)
    }
}

//MARK: App Saved Status
extension Cache {
    
//    class var configurations: Configurations? {
//        set {
//            Cache.set(object: newValue, forKey: Keys.configurations.rawValue)
//        } get {
//            if let data = Cache.object(of: Configurations.self, key: Keys.configurations.rawValue) {
//                return data
//            }
//            return nil
//        }
//    }
//    
//    class var user: User? {
//        set {
//            Cache.set(object: newValue, forKey: Keys.currentUser.rawValue)
//        } get {
//            if let data = Cache.object(of: User.self, key: Keys.currentUser.rawValue) {
//                return data
//            }
//            return nil
//        }
//    }
    
    static var isFirstAppLaunch: Bool {
        set {
            Cache.set(object: newValue, forKey: Keys.isFirstAppLaunch.rawValue)
        }
        get {
            if let type = Cache.object(of: Bool.self, key: Keys.isFirstAppLaunch.rawValue) {
                return type
            }
            return true
        }
    }
}
