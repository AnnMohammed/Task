//
//  Constants.swift
//  Maintenance
//
//  Created by Ann Mohammed on 02/12/2023.
//

import Foundation

final class Constants {
    static var baseURL = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as! String
    static var realTimeURL = Bundle.main.object(forInfoDictionaryKey: "RealTimeURL") as! String
}
