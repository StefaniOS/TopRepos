//
//  RepositoryCell.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: RepositoryViewModel?) {
        if let viewModel = viewModel {
            textLabel?.text = "\(viewModel.name)"
            textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
            self.detailTextLabel?.text = viewModel.url
            let detailText = "\(viewModel.stars) Stars | \(viewModel.url)"
            self.detailTextLabel?.text = detailText
            
//            self.imageView?.setImage(from: viewModel.owner.avatarUrl)
            
            if #available(iOS 13.0, *), viewModel.isPrivate {
                let image = UIImage(systemName: viewModel.imageName)
                self.accessoryView = UIImageView(image: image)
            }
        }
    }
}
