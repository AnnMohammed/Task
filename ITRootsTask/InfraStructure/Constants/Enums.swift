//
//  Enums.swift
//  Maintenance
//
//  Created by Ann Mohammed on 02/12/2023.
//

import UIKit

enum AppLanguage: Int {
    case english = 1
    case arabic = 2
    
    var languageIdentifier: String {
        switch self {
        case .arabic:
            return "ar"
        case .english:
            return "en"
        }
    }
    
    init?(languageIdentifier: String) {
        switch languageIdentifier {
        case "en":
            self = .english
        case "ar":
            self = .arabic
        default:
            return nil
        }
    }
}

enum URLPath: String {
    
    // MARK: - General
    case general               =  "General/GetConfiguration"
    case categories            =  "General/GetAllCategories"
    case subcategories         =  "General/GetAllSubCategoriesByMainCategory"
    
    // MARK: - Auth
    case login                 = "Client/Login"
    case register              = "Client/Register"
    case sendOTP               = "Client/SendOTP"
    
    // MARK: - Home
    
    // MARK: - Servieces
    
    // MARK: - Orders
    
    // MARK: - Profile
    case editProfile           = "Client/EditProfile"
    case changePassword        = "Client/ChangePassword"
    
    // MARK: - Address
    case currentNeighbourhood  =  "Address/GetCurrentNeighbourhood"
    case addressList           =  "Address/GetContactAddress"
    case deleteAddress         =  "Address/DeleteAddress"
    case addAdrress            =  "Address/AddAddress"
    
    // MARK: - Devices
    case devicesList           =  "Customer/GetAllCustomerDevices"
    case deleteDevice          =  "Customer/DeleteDevice"
    case addDevice             =  "Customer/AddNewDevice"
}

enum Keys: String {
    case configurations   = "CONFIGURATIONS"
    case apiToken         = "API_TOKEN"
    case fcmToken         = "FCM_TOKEN"
    case currentUser      = "CURRENT_USER"
    case isFirstAppLaunch = "IS_FIRST_APP_LAUNCH"
}

protocol AppError: Error {
    var localizedErrorDescription: String { get }
}

enum LanguageVCPath {
    case profile
    case splash
}

enum ItemType {
    case address
    case mainCategory
    case subCategory
}

enum ReservationAction {
    case edit
    case changeTable
    case cancel
    case noShow
}
