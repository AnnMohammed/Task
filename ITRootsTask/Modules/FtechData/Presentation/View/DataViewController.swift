//
//  DataViewController.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import UIKit

class DataViewController: BaseViewControllerWithVM<DataListViewModel> {

    @IBOutlet weak var dataTableView: UITableView!{
        didSet {
            dataTableView.delegate = self
            dataTableView.dataSource = self
            dataTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func bind() {
        super.bind()
        
        viewModel.viewDidLoad()
        
        viewModel.reloadDataListTableView
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.dataTableView.reloadData()
            }
            .store(in: &cancellables)
        
    }
    

}

extension DataViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberData
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = viewModel.getDataIndex(at: indexPath.row)?.title
        return cell
    }
    
}
