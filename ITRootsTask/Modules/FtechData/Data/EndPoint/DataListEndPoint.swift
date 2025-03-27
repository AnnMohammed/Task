//
//  DataListEndPoint.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import Foundation
import Alamofire

enum DataListEndPoint: Endpoint {
    
    case  DataList
    
    var path: String {
        
        switch self {
        case .DataList:
            return "posts"
        }
    }
    
    //MARK: Method
    var method: HTTPMethod {
        switch self {
        case .DataList:
            return .get
        }
    }
    
    //MARK: Params
    var parameters: Parameters? {
        switch self {
        case .DataList:
            return [:]
        }
    }
    
    //MARK: Encoding
    var encoding: ParameterEncoding {
        switch self {
        case .DataList:
            return URLEncoding.default
        }
    }
}
