//
//  PostCell.swift
//  ios101-project5-tumblr
//
//  Created by Kemely Alfonso on 7/15/25.
//


//
//  PostCell.swift
//  ios101-project5-tumbler
//

import UIKit

class PostCell: UITableViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // Configure the image view for better display
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        
        // Configure the summary label for better text display
        summaryLabel.numberOfLines = 0 // Allow multiple lines
        summaryLabel.lineBreakMode = .byWordWrapping
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        // Reset the image view to avoid showing incorrect images during cell reuse
        postImageView.image = nil
        summaryLabel.text = nil
    }
}