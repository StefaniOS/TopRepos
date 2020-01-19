//
//  UIImageView+Url.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
   func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            let image = UIImage(data: imageData)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
