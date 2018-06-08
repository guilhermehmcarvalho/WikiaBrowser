//
//  ImageService.swift
//  Fandom
//
//  Created by Guilherme on 08/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

class ImageService {
    // MARK: - Variables
    
    weak public var delegate: ImageServiceDelegate?
    
    // MARK: - Public
    
    func getImage(url: String) -> Request? {
        return Alamofire.request(url).responseImage { response in
            DispatchQueue.main.async {
                if let image = response.result.value {
                    self.delegate?.getImageDidComplete(image: image)
                } else {
                    self.delegate?.getImageDidFail(failure: ServiceFailureType.server)
                }
            }
        }
    }
}

// MARK: - Delegate Protocol

protocol ImageServiceDelegate: class {
    func getImageDidComplete(image: UIImage)
    func getImageDidFail(failure: ServiceFailureType)
}
