////
////  UserDefaultsManeger.swift
////  BaseProgect
////
////  Created by Ann Mohammed on 14/09/2022.
////
//
//import Foundation
//
//// MARK: - ...  Defaults properties
//var UD: Defaults {
//    if Defaults.Static.instance == nil {
//        Defaults.Static.instance = Defaults()
//    }
//    return Defaults.Static.instance!
//}
//
//// MARK: - ...  Defaults properties
//internal class Defaults {
//    
//    struct Static {
//        static var instance: Defaults?
//    }
//    
//    @StoredDefaults("LanguageState")
//    var languageState: Bool?
//    
//    @StoredDefaults("OnBoardingState")
//    var onBoardingState: Bool?
//    
//    @StoredDefaults("firstLogin")
//    var firstLogin: Bool?
//    
//    @StoredDefaults("notificationBackgroundTap")
//    var notificationBackgroundTap: Bool?
//    
//    @StoredDefaults("AccessToken")
//    var accessToken: String?
//    
//    @StoredDefaults("user")
//    var user: LoginUser?
//    
//    @StoredDefaults("progress")
//    var progress: ProgressData?
//    
//    @StoredDefaults("pkpass")
//    var pkpass: String?
//    
//    @StoredDefaults("company")
//    var company: LoginCompany?
//    
//    @StoredDefaults("userType")
//    var userType: String?
//    
//    @StoredDefaults("points")
//    var points: Int?
//    
//    @StoredDefaults("countReadUNRead")
//    var countReadUNRead: Int?
//    
//    @StoredDefaults("lat")
//    var lat: String?
//    
//    @StoredDefaults("long")
//    var long: String?
//    
//    @StoredDefaults("FCM")
//    var FCMToken: String?
//    
//    @StoredDefaults("SocketID")
//    var SocketID: String?
//    
//    @StoredDefaults("firstLogin")
//    var firstSelectCities: Bool?
//    
//    @StoredDefaults("testCompany")
//    var testCompany: Bool?
//    
//    @StoredDefaults("isLocationOpened")
//    var isLocationOpened: Bool?
//    
//    @StoredDefaults("isPresented")
//    var isPresented: Bool?
//}
