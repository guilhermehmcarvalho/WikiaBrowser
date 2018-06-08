//
//  WikiTableViewCell.swift
//  Fandom
//
//  Created by Guilherme on 07/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit
import Alamofire

class WikiTableViewCell: UITableViewCell {
    
    // MARK: - Varialbes
    
    static let reuseIdentifier = "WikiCell"

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    let imageService = ImageService()
    var imageRequest: Request?
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageService.delegate = self
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        descriptionLabel.text = ""
        cellImage.image = nil
        imageRequest?.cancel()
    }

    // MARK: - Public
    
    func configureWith(_ wiki: WikiaItem) {
        titleLabel.text = wiki.title
        descriptionLabel.text = wiki.desc
        if let image = wiki.image {
            imageRequest = imageService.getImage(url: image)
        }
    }
}

// MARK: - ImageServiceDelegate

extension WikiTableViewCell: ImageServiceDelegate {
    func getImageDidComplete(image: UIImage) {
        cellImage.image = image
    }
    
    func getImageDidFail(failure: ServiceFailureType) {
        cellImage.image = nil
    }
}
