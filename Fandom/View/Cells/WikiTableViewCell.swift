//
//  WikiTableViewCell.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit

class WikiTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "WikiCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public
    
    func configureWith(_ wiki: WikiaItem) {
        titleLabel.text = wiki.title
        descriptionLabel.text = wiki.desc
        
        //request = imageService.getImage(size: .coverBig, game: game, retinaSize: RetinaSize.retina2x)
    }
}
