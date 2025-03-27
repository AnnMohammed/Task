//
//  BaseFactory.swift
//  Wala
//
//  Created by Ann on 05/02/2024.
//

import Foundation
import UIKit

protocol FactoryProtocol {
    var network: NetworkLayerProtocol { get }
    var viewController: UIViewController { get }
}

extension FactoryProtocol {
    var network: NetworkLayerProtocol {
        return NetworkManager()
    }
}
