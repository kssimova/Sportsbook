//
//  EventsViewController.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import UIKit

/**
 View controller displaying a list of events.
 */
class EventsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var eventsLabel: UILabel!
    @IBOutlet weak var eventsTableView: UITableView!
    
    // MARK: - Properties
    
    /// View model for handling events-related data.
    var viewModel: EventsViewModel?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupLabels()
        self.setupTableView()
        self.fetchEvents()
    }
    
    // MARK: - Private Methods
    
    /**
     Sets up the appearance of labels.
     */
    private func setupLabels() {
        eventsLabel.font = Typography.bigHeading.value.font
    }
    
    /**
     Sets up the appearance and behavior of the table view.
     */
    private func setupTableView() {
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        eventsTableView.register(cellClass: EventTableViewCell.self)
        eventsTableView.rowHeight = UITableView.automaticDimension
    }
    
    /**
     Fetches events from the view model.
     */
    private func fetchEvents() {
        viewModel?.fetchEventsBySportId { [weak self] result in
            switch result {
            case .success(_):
                self?.reloadData()
            case .failure(let error):
                print("Failed to fetch events: \(error)")
            }
        }
    }
    
    /**
     Reloads data in the table view on the main thread.
     */
    private func reloadData() {
        DispatchQueue.main.async {
            self.eventsTableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.events[section].matches.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        
        // Get unique dates from the events array
        let uniqueDates = Set(viewModel.events.map { $0.date })
        // Return the count of unique dates
        return uniqueDates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as EventTableViewCell
        let match = viewModel.events[indexPath.section].matches[indexPath.row]
        cell.viewModel = EventTableViewCellViewModel(match: match)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return nil }
    
        let date = viewModel.events[section].date
        return viewModel.getFormattedDate(dateFormat: "MMM dd, yyyy", date: date)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 30))
        headerView.backgroundColor = .lightGray
        
        let label = UILabel(frame: CGRect(x: 16, y: 0, width: tableView.bounds.width - 30, height: 30))
        label.font = Typography.heading.value.font
        label.textColor = .darkGray
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        
        headerView.addSubview(label)
        return headerView
    }
}
