//
//  ValidationErrors.swift
//  Maintenance
//
//  Created by Ann Mohammed on 02/12/2023.
//

import Foundation

enum NetworkError: AppError, Equatable {
    case general(String)
    case noNetwork
    case unknown
    case nullData
    case badRequest
    case unauthorized
    case notFound
    case serverError
    case timeOut
    case decodingError
    case encodingError
    
    var localizedErrorDescription: String {
        switch self {
        case .general(let message):
            return message
        case .noNetwork:
            return "no_internet"
        case .unknown:
            return "An unknown error occurred."
        case .nullData:
            return "Data is Null."
        case .badRequest:
            return "The request was malformed or invalid."
        case .unauthorized:
            return "The request requires authentication."
        case .notFound:
            return "The requested resource could not be found."
        case .serverError:
            return "An error occurred on the server."
        case .timeOut:
            return "Server timeOut."
        case .decodingError:
            return "An error occurred while decoding the response."
        case .encodingError:
            return "An error occurred while encoding the request."
        }
    }
}
