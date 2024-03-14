//
//  RunnerCollectionViewCell.swift
//  SportsBook
//
//  Created by Kristina Simova on 13.03.24.
//

import UIKit

/// Collection view cell displaying information about a runner in a market.
class RunnerCollectionViewCell: UICollectionViewCell {
    
    static let cellReuseIdentifier: String = "RunnerCollectionViewCellIdentifier"
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var oddLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.setupFonts()
    }
    
    // MARK: - Private Methods
    
    /// Sets up the fonts for title and odd labels.
    private func setupFonts() {
        titleLabel.font = Typography.mediumHeading.value.font
        oddLabel.font = Typography.mediumHeading.value.font
    }
}
