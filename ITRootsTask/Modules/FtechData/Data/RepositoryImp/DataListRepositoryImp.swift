//
//  DataListRepositoryImp.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import Combine

class DataListRepositoryImp: DataListRepositoryProtocol{
    
    private let apiClient: NetworkLayerProtocol
    
    init(apiClient: NetworkLayerProtocol) {
        self.apiClient = apiClient
    }
    
}

extension DataListRepositoryImp {
    
    func dataList() async throws -> [ItemsModel] {
            let endPoint = DataListEndPoint.DataList
            do {
                let response: [ItemsModel] = try await apiClient.request(endPoint)
                
                return response
            } catch {
                throw error
            }
        }
}
