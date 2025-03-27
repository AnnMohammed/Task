//
//  HomeViewController.swift
//  ITRootsTask
//
//  Created by Ann on 27/03/2025.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var horizontalCollectionView: UICollectionView!{
        didSet{
            horizontalCollectionView.delegate = self
            horizontalCollectionView.dataSource = self
            horizontalCollectionView.register(UINib(nibName: "HorizontalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HorizontalCollectionViewCell")
        }
    }
    @IBOutlet weak var verticalTableView: UITableView!{
        didSet{
            verticalTableView.delegate = self
            verticalTableView.dataSource = self
            verticalTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
    }
    
    let horizontalItems = ["Item 1", "Item 2", "Item 3", "Item 4"]
    let verticalItems = ["Item A", "Item B", "Item C", "Item D", "Item B", "Item C", "Item D", "Item B", "Item C", "Item D","Item A", "Item B", "Item C", "Item D", "Item B", "Item C"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: .plain,
            target: self,
            action: #selector(openSettings)
        )
        
    }
    @objc private func openSettings() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
}

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return horizontalItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontalCollectionViewCell", for: indexPath) as? HorizontalCollectionViewCell else {return UICollectionViewCell()}
        cell.HorizontalItemLabel.text = horizontalItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (horizontalCollectionView.frame.size.width  - 30) / 4, height: horizontalCollectionView.frame.size.height)
    }
    
}
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return verticalItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = verticalItems[indexPath.row]
        return cell
    }
    
}
