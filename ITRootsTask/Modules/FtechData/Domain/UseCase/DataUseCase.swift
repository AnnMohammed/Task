//
//  DataUseCase.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import Foundation
import Combine

class DataUseCase {
    
    private let repo: DataListRepositoryProtocol
    
    init(repository: DataListRepositoryProtocol) {
        self.repo = repository
    }
    
    func execute() async throws -> [ItemsModel] {
        return try await repo.dataList()
    }
    
}
