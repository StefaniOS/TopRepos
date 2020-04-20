//
//  RepositoryDetailViewController.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 18.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import UIKit

class RepositoryDetailViewController: UIViewController {
    
    fileprivate var detailViewModel: RepositoryDetailViewModel!
    
    private let avatarImageView = UIImageView()
    internal let titleLabel = UILabel()
    internal let descriptionLabel = UILabel()
    internal let tagsLabel = UILabel()
    internal let urlLabel = UILabel()
    internal let languageLabel = UILabel()
    
    init(detailViewModel: RepositoryDetailViewModel) {
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        detailViewModel.fetchData { viewModel in
            DispatchQueue.main.async {
                self.updateContentView(with: viewModel)
            }
        }
    }
    
    func setupViews() {
        view.backgroundColor = .white
        
        // Setup navigation bar
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = detailViewModel.rowItemViewModel.name
        
        setupSubviews()
    }
}

// MARK: - Content View
extension RepositoryDetailViewController {
    
    func updateContentView(with viewModel: RepositoryRowViewModel) {
        
        // Fill content with data
        avatarImageView.setImage(from: viewModel.owner.avatarUrl)
        titleLabel.text = viewModel.fullName
        descriptionLabel.text = viewModel.description
        
        // Just a quick solution. Do not do this in real projects!!!
        tagsLabel.text = "| WATCH:\(viewModel.watch) | STAR:\(viewModel.stars) | FORK:\(viewModel.forks) |"
        
        urlLabel.text = "URL: \(viewModel.url)"
        if let language = viewModel.language {
            languageLabel.text = "Language: \(language)"
        }
    }
    
    private func setupSubviews() {
        
        let padding: CGFloat = 16
        
        // Avatar Image View
        view.addSubview(avatarImageView)
        avatarImageView.contentMode = .scaleAspectFit
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        avatarImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: view.frame.size.height/3).isActive = true
        
        let infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = padding
        infoStackView.alignment = .top
        view.addSubview(infoStackView)
        
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        infoStackView.topAnchor.constraint(equalTo: avatarImageView.safeAreaLayoutGuide.bottomAnchor, constant: padding).isActive = true
        infoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        infoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding).isActive = true
        infoStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        // Title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        infoStackView.addArrangedSubview(titleLabel)
        
        // Description Text
        descriptionLabel.numberOfLines = 0
        infoStackView.addArrangedSubview(descriptionLabel)
        
        // Tags
        tagsLabel.font = UIFont.boldSystemFont(ofSize: 16)
        tagsLabel.numberOfLines = 0
        infoStackView.addArrangedSubview(tagsLabel)
        
        // Repository URL
        descriptionLabel.numberOfLines = 0
        infoStackView.addArrangedSubview(urlLabel)
        
        // Language
        languageLabel.numberOfLines = 0
        infoStackView.addArrangedSubview(languageLabel)
        
        let spacing = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height/3))
        infoStackView.addArrangedSubview(spacing)
    }
}
