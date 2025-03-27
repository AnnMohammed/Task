//
//  NetworkManager.swift
//  Maintenance
//
//  Created by Ann Mohammed on 02/12/2023.
//

import Foundation
import Alamofire

protocol NetworkLayerProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, NetworkError>) -> Void)
    func upload<T: Decodable>(_ endpoint: Endpoint, uploadData: UploadDataModel?) async throws -> T
}

class NetworkManager: NetworkLayerProtocol {
    
    private var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        configuration.headers = HTTPHeaders.default
        let interceptor = RequestInterceptor()
        let session = Session(configuration: configuration, interceptor: interceptor)
        return session
    }()
    
    init() {}
    
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        print("\nURL: \(endpoint.urlRequest?.url?.absoluteString ?? "")")
        print("\nHeaders:\n \(endpoint.urlRequest?.headers ?? [:])")
        print("\nBody:\n \(endpoint.parameters ?? [:])")
        
        let request = session.request(endpoint)
        let data = request.serializingData()
        
        do {
            let response = try await data.value // Returns full DataResponse<TestResponse, AFError>
            let decodedValue = try JSONDecoder().decode(T.self, from: response)
            print("\n\nResponse:\n\n \(decodedValue)\n\n**********************************************\n")
            return decodedValue
        } catch let error as DecodingError {
            throw self.handleNetworkError(
                .responseSerializationFailed(
                    reason: .decodingFailed(error: error)))
        } catch {
            throw self.handleNetworkError(error as? AFError)
        }
    }
    
    func handleNetworkError(_ error: AFError?) -> NetworkError {
        if let afError = error {
            switch afError {
            case .sessionTaskFailed:
                if let urlError = afError.underlyingError as? URLError {
                    switch urlError.code {
                    case .timedOut:
                        return .timeOut
                    default:
                        return .general(urlError.localizedDescription)
                    }
                } else {
                    return .unknown
                }
            case .responseSerializationFailed:
                if let decodingError = afError.underlyingError as? DecodingError {
                    switch decodingError {
                    case .dataCorrupted, .keyNotFound, .typeMismatch, .valueNotFound:
                        print(decodingError)
                        print(afError)
                        return .decodingError
                    @unknown default:
                        return .general(decodingError.localizedDescription)
                    }
                } else {
                    return .general(afError.localizedDescription)
                }
            case .requestRetryFailed:
                return .serverError
            default:
                return .general(afError.localizedDescription)
            }
        } else {
            return .unknown
        }
    }
    
    func request<T: Decodable>(
        _ endpoint: Endpoint,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        print("\n**********************************************\n")
        print("\nURL: \(endpoint.urlRequest?.url?.absoluteString ?? "")")
        print("\nHeaders:\n \(endpoint.urlRequest?.headers ?? [:])")
        print("\nBody:\n \(endpoint.parameters ?? [:])")
        if !(NetworkMonitor.shared.isConnected) {
            completion(.failure(.noNetwork))
        }
        session.request(endpoint)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let model):
                    print("\n\nResponse:\n\n \(model)\n\n**********************************************\n")
                    completion(.success(model))
                case .failure(let error):
                    completion(.failure(self.handleNetworkError(error)))
                }
            }
    }
    
    func upload<T: Decodable>(_ endpoint: Endpoint, uploadData: UploadDataModel?) async throws -> T {
        print("\n**********************************************\n")
        print("\nURL: \(endpoint.urlRequest?.url?.absoluteString ?? "")")
        print("\nHeaders:\n \(endpoint.urlRequest?.headers ?? [:])")
        print("\nBody:\n \(endpoint.parameters ?? [:])")
        
        let request = session.upload(
            multipartFormData: { formData in
                if let data = uploadData {
                    formData.append(
                        data.data,
                        withName: data.name,
                        fileName: data.fileName,
                        mimeType: data.mimeType
                    )
                }
                // Add any other form data parameters here
                for (key, value) in endpoint.parameters ?? [:] {
                    if let data = value as? Data {
                        formData.append(data, withName: key)
                    } else if let string = value as? String {
                        formData.append(string.data(using: .utf8)!, withName: key)
                    } else if let int = value as? Int {
                        let stringValue = String(int)
                        formData.append(stringValue.data(using: .utf8)!, withName: key)
                    } else if let array = value as? [Any] {
                        for (index, element) in array.enumerated() {
                            let elementKey = "\(key)[\(index)]"
                            formData.append("\(element)".data(using: .utf8)!, withName: elementKey)
                        }
                    } else if let dictionary = value as? [String: Any] {
                        for (dictKey, dictValue) in dictionary {
                            let elementKey = "\(key)[\(dictKey)]"
                            formData.append("\(dictValue)".data(using: .utf8)!, withName: elementKey)
                        }
                    } else {
                        print("Unsupported parameter type: \(type(of: value))")
                    }
                }
            },
            with: endpoint
        )
        
        request.uploadProgress { progress in
            print("Upload progress: \(progress.fractionCompleted)")
        }
        
        let data = request.serializingData() // Serialize the response to raw data
        
        do {
            let response = try await data.value // Fetch the raw response data
            let decodedValue = try JSONDecoder().decode(T.self, from: response) // Decode the response
            print("\n\nResponse:\n\n \(decodedValue)\n\n**********************************************\n")
            return decodedValue
        } catch let error as DecodingError {
            throw handleNetworkError(
                .responseSerializationFailed(
                    reason: .decodingFailed(error: error)
                )
            )
        } catch {
            throw handleNetworkError(error as? AFError)
        }
    }
    
//    func upload<T: Decodable>(
//        _ endpoint: Endpoint,
//        uploadData: UploadDataModel? = nil,
//        completion: @escaping (Result<T, NetworkError>) -> Void
//    ) {
//        let request = session.upload(
//            multipartFormData: {
//                formData in
//                if let data = uploadData {
//                    formData.append(
//                        data.data,
//                        withName: data.name,
//                        fileName: data.fileName,
//                        mimeType: data.mimeType
//                    )
//                }
//                // Add any other form data parameters here
//                for (key, value) in endpoint.parameters ?? [:] {
//                    if let data = value as? Data {
//                        formData.append(data, withName: key)
//                    } else if let string = value as? String {
//                        formData.append(string.data(using: .utf8)!, withName: key)
//                    } else if let int = value as? Int {
//                        let stringValue = String(int)
//                        formData.append(stringValue.data(using: .utf8)!, withName: key)
//                    } else if let array = value as? [Any] {
//                        for (index, element) in array.enumerated() {
//                            let elementKey = "\(key)[\(index)]"
//                            formData.append("\(element)".data(using: .utf8)!, withName: elementKey)
//                        }
//                    } else if let dictionary = value as? [String: Any] {
//                        for (dictKey, dictValue) in dictionary {
//                            let elementKey = "\(key)[\(dictKey)]"
//                            formData.append("\(dictValue)".data(using: .utf8)!, withName: elementKey)
//                        }
//                    } else {
//                        print("Unsupported parameter type: \(type(of: value))")
//                    }
//                }
//            },
//            with: endpoint
//        )
//        request.uploadProgress(closure: { progress in
//            print("Upload progress: \(progress.fractionCompleted)")
//        })
//        request.validate(statusCode: 200..<300)
//            .responseDecodable(of: T.self) { response in
//                switch response.result {
//                case .success(let value):
//                    completion(.success(value))
//                case .failure(let error):
//                    completion(.failure(self.handleNetworkError(error)))
//                }
//            }
//        request.resume()
//    }
}

extension DataRequest {
    func responseDecodableThrowing<T: Decodable>(of type: T.Type, decoder: JSONDecoder = JSONDecoder()) async throws -> T {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let result = try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<T, Error>) in
            self.responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decodedValue = try decoder.decode(T.self, from: data)
                        continuation.resume(returning: decodedValue)
                    } catch {
                        continuation.resume(throwing: AFError.responseSerializationFailed(reason: .decodingFailed(error: error)))
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        return result
    }
}
