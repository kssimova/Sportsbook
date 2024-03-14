//
//  SportsViewController.swift
//  SportsBook
//
//  Created by Kristina Simova on 10.03.24.
//

import UIKit

/**
 View controller displaying a list of sports.
 */
class SportsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sportsLabel: UILabel!
    @IBOutlet weak var sportsTableView: UITableView!
    
    // MARK: - Properties
    
    /// View model for handling sports-related data.
    var viewModel: SportsViewModel?
    
    /// Coordinator responsible for navigation.
    var coordinator: AppCoordinator?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the UI
        self.setupLabels()
        self.fetchSports()
        self.setupTableView()
    }
    
    // MARK: - Private Methods
    
    /**
     Set up the appearance of labels.
     */
    private func setupLabels() {
        sportsLabel.text = "Sports"
        sportsLabel.font = Typography.bigHeading.value.font
    }
    
    /**
     Fetch sports data using the view model.
     */
    private func fetchSports() {
        guard let viewModel = viewModel else { return }
        
        viewModel.fetchSports { [weak self] result in
            switch result {
            case .success(_):
                self?.reloadData()
            case .failure(let error):
                print("Failed to fetch sports: \(error)")
            }
        }
    }
    
    /**
     Set up the sports table view.
     */
    private func setupTableView() {
        sportsTableView.delegate = self
        sportsTableView.dataSource = self
        
        sportsTableView.register(cellClass: SportTableViewCell.self)
        sportsTableView.rowHeight = UITableView.automaticDimension
    }
    
    /**
     Reload the data in the sports table view.
     */
    private func reloadData() {
        DispatchQueue.main.async {
            self.sportsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SportsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.sports.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as SportTableViewCell
        let cellViewModel = SportTableViewCellViewModel(sport: viewModel.sports[indexPath.row])
        cell.viewModel = cellViewModel
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        
        viewModel.didSelectSport?(viewModel.sports[indexPath.row].id)
    }
}
