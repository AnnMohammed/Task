//
//  DataListViewModel.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import Combine
import Foundation

protocol DataListViewModelProtocol {
    
    func viewDidLoad()
    var reloadDataListTableView  : PassthroughSubject<Void, Never> { get }
    var isTableHidden: CurrentValueSubject<Bool, Never> { get }
    
}

class DataListViewModel: BaseViewModel, DataListViewModelProtocol {
    
    var reloadDataListTableView: PassthroughSubject<Void, Never> = .init()
    private let dataListUseCase :  DataUseCase
    var isTableHidden = CurrentValueSubject<Bool, Never>(true)
    var navigateToOldOrNewQuestion: PassthroughSubject<(Int, String?), Never> = .init()
    private var dataListData: [ItemsModel] = []
    
    
    init(dataListUseCase : DataUseCase) {
        self.dataListUseCase = dataListUseCase
    }
    
    var numberData: Int {
        return dataListData.count
    }
    
    func getDataIndex(at index: Int) -> ItemsModel? {
        return dataListData[index]
    }
    
    func viewDidLoad() {
        Task {
            await getData()
        }
    }
    
    func getData() async {
        isLoading.send(true)
        do {
            let request = try await dataListUseCase.execute()
            dataListData = request
            if dataListData.isEmpty == true {
                isTableHidden.send(false)
            }else {
                isTableHidden.send(true)
            }
            reloadDataListTableView.send()
            isLoading.send(false)
        } catch {
            isLoading.send(false)
            if let error = error as? NetworkError {
                
                if error == .unauthorized {
                    errorUnAuthorizedPublisher.send(error.localizedErrorDescription)
                }else {
                    errorPublisher.send(error.localizedErrorDescription)
                }
                
            } else {
                errorPublisher.send(error.localizedDescription)
            }
        }
    }
}
