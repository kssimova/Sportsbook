//
//  EventTableViewCell.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import UIKit

/**
 Table view cell displaying information about an event.
 */
class EventTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var marketTypeLabel: UILabel!
    @IBOutlet weak var homeTeamImageView: UIImageView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    @IBOutlet weak var awayTeamImageView: UIImageView!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var runnersCollectionView: UICollectionView!
    
    // MARK: - Properties
    
    /// View model associated with the cell.
    var viewModel: EventTableViewCellViewModel! {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Lifecycle Methods
    
    /**
     Initializes the cell from the storyboard.
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupFonts()
        self.setupCollectionView()
    }

    // MARK: - Private Methods
    
    /**
     Configures font for labels.
     */
    private func setupFonts() {
        marketTypeLabel.font = Typography.mediumHeading.value.font
        homeTeamLabel.font = Typography.mediumHeading.value.font
        awayTeamLabel.font = Typography.mediumHeading.value.font
        dateLabel.font = Typography.smallHeading.value.font
    }
    
    /**
     Sets up the collection view.
     */
    private func setupCollectionView() {
        runnersCollectionView.dataSource = self
        runnersCollectionView.delegate = self
        runnersCollectionView.register(UINib(nibName: String(describing: RunnerCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: RunnerCollectionViewCell.cellReuseIdentifier)
        
        if let flowLayout = runnersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
    
    /**
     Updates UI with data from view model.
     */
    private func updateUI() {
        let teams = extractTeamNames(from: viewModel.eventName, separators: [" v ", " vs "])
        
        guard let teams = teams else { return }
        
        self.homeTeamLabel.text = teams.0
        self.homeTeamImageView.image = UIImage(named: teams.0.replacingOccurrences(of: " ", with: ""))
        self.homeTeamImageView.isHidden = self.homeTeamImageView.image == nil
        
        self.awayTeamLabel.text = teams.1
        self.awayTeamImageView.image = UIImage(named: teams.1.replacingOccurrences(of: " ", with: ""))
        self.awayTeamImageView.isHidden = self.awayTeamImageView.image == nil
        
        self.dateLabel.text = String(format: "Start time: %@", formatTime(for: viewModel.date))
        self.dateLabel.font = Typography.smallHeading.value.font
        
        self.setMarketType()
        self.runnersCollectionView.reloadData()
    }
    
    /**
     Extracts team names from event name using given separators.
     */
    private func extractTeamNames(from input: String, separators: [String]) -> (String, String)? {
        for separator in separators {
            if let range = input.range(of: separator) {
                let firstTeam = String(input[..<range.lowerBound])
                let secondTeam = String(input[range.upperBound...])
                return (firstTeam, secondTeam)
            }
        }
        return nil
    }
    
    /**
     Formats date into string.
     */
    private func formatTime(for date: Date, format: String = "HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    /**
     Sets the market type label.
     */
    private func setMarketType() {
        self.marketTypeLabel.text = viewModel.marketType
    }
}

// MARK: - UICollectionViewDataSource
extension EventTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.match.primaryMarket.runners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RunnerCollectionViewCellIdentifier", for: indexPath) as? RunnerCollectionViewCell {
            let runner = viewModel.match.primaryMarket.runners[indexPath.item]
            
            let titleLabelText = viewModel.getWinDrawWinLabelLabel(by: indexPath.item)
            
            switch runner {
            case .winDrawWin(let data):
                cell.titleLabel.text = titleLabelText
                cell.oddLabel.text = String(format: "%d / %d", data.odds.numerator, data.odds.denominator)
            case .totalGoalsInMatch(let data):
                cell.titleLabel.text = String(format: "%d", data.totalGoals)
                cell.oddLabel.text = String(format: "%d / %d", data.odds.numerator, data.odds.denominator)
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension EventTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth / 2) / 3.5 /// Adjust as needed - three items should fit half screen
        
        return CGSize(width: cellWidth, height: collectionView.bounds.height)
    }
}

// MARK: - ReusableCell & NibLoadableView Protocols
extension EventTableViewCell: ReusableCell {}
extension EventTableViewCell: NibLoadableView {}
