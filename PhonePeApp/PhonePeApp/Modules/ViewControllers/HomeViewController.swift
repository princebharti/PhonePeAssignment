//
//  HomeViewController.swift
//  PhonePeApp
//
//  Created by Prince Bharti on 23/09/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        configureUI()
        updateViewModel()
    }
    
    
    func configureUI() {
        tableView.register(HomeTableViewCell.nib, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func updateViewModel() {
        viewModel.fetchDataAndUpdate()
    }
    
    func refreshUI() {
        tableView.reloadData()
    }
    
}


extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let childViewModel = viewModel.items[indexPath.row]
        switch childViewModel.cellType {
        case .detail:
            if let detailCell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell {
                detailCell.configureUI(viewModel: childViewModel)
                detailCell.delegate = self
                return detailCell
            } else { return UITableViewCell() }
            
        default:
            return UITableViewCell()
        }
    }
    
}

extension HomeViewController: ViewModelDelegate {
    func viewModelDidUpdate(identifier: String?, data: Any?) {
        refreshUI()
    }
    
    func viewModelDidFail(identifier: String?, error: Error?) {
        refreshUI()
    }
}


extension HomeViewController: HomeTableViewCellDelegate {
    
    func didTapAddToPlaylist() {
        //TODO::
    }
    
}




