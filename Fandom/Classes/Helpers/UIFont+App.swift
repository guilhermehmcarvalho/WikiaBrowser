//
//  UIFont+App.swift
//  Fandom
//
//  Created by Guilherme Carvalho on 10/06/2018.
//  Copyright © 2018 Guilherme. All rights reserved.
//

import UIKit

extension UIFont {
    
    class App {
        class func rubikRegular(ofSize size: CGFloat) -> UIFont {
            guard let font = UIFont(name: AppFontNames.rubikRegular, size: size) else {
                fatalError("Font not found: \(AppFontNames.rubikRegular)")
            }
            return font
        }
        
        class func rubikMedium(ofSize size: CGFloat) -> UIFont {
            guard let font = UIFont(name: AppFontNames.rubikMedium, size: size) else {
                fatalError("Font not found: \(AppFontNames.rubikMedium)")
            }
            return font
        }
    }
    
    private struct AppFontNames {
        static let rubikRegular = "Rubik-Regular"
        static let rubikMedium = "Rubik-Medium"
    }
}
