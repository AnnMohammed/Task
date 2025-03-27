//
//  DataListFactory.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import Foundation
import UIKit

enum DataListFactory {

    case dataList

    // MARK: Variables
    private var dataRepo: DataListRepositoryProtocol {
        return DataListRepositoryImp(apiClient: NetworkManager())
    }

    // MARK: ViewControllers
    var viewController: UIViewController {

        switch self {
        case .dataList:
            let dataUseCase = DataUseCase(repository: dataRepo)
            let vm = DataListViewModel(dataListUseCase: dataUseCase)
            let vc = DataViewController(viewModel: vm)
            return vc
        }
    }
}
