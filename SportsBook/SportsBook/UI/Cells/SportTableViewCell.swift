//
//  SportTableViewCell.swift
//  SportsBook
//
//  Created by Kristina Simova on 12.03.24.
//

import UIKit

/**
 Table view cell displaying information about a sport.
 */
class SportTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sportImageView: UIImageView!
    @IBOutlet weak var sportLabel: UILabel!
    
    // MARK: - Properties
    
    /// View model associated with the cell.
    var viewModel: SportTableViewCellViewModel! {
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
        // Initialization code
    }

    /**
     Configures the selected state of the cell.
     */
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private Methods
    
    /**
     Updates the user interface of the cell based on the view model.
     */
    private func updateUI() {
        sportLabel.text = viewModel.sport.name
        sportLabel.font = Typography.mediumHeading.value.font
        
        // Load local image based on sport name
        let imageName = viewModel.sport.name.replacingOccurrences(of: " ", with: "")
        // Note: Ideally, images should be loaded using a framework for downloading and caching images
        sportImageView.image = UIImage(named: imageName)
    }
    
}

// MARK: - ReusableCell and NibLoadableView Conformance

extension SportTableViewCell: ReusableCell {}
extension SportTableViewCell: NibLoadableView {}
