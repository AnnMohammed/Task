//
//  DataListRepository.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import Combine

protocol DataListRepositoryProtocol {
    
    func dataList() async throws -> [ItemsModel]
}
