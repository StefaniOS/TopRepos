//
//  RepositoryListViewController.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 17.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import UIKit

class RepositoryListViewController: UIViewController {
    
    fileprivate let tableView = UITableView()
    
    fileprivate let cellIdentifier = "cell"
    
    private var repeater: Timer?
    private var repeaterTimeInterval: TimeInterval = 5
    
    private let listViewModel: RepositoryListViewModel!
    private var itemViewModels: [RepositoryRowViewModel] = [] {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                self.tableView.reloadData()
            }
        }
    }
    
    
    init(viewModel: RepositoryListViewModel) {
        self.listViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register table view cell
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: cellIdentifier)
        
        // Setup views
        setupViews()
        
        // Fetch the data from server
        listViewModel.fetchData { [weak self] viewModels in
            self?.itemViewModels = viewModels
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Run repeater to refetch the data
//        runRepeater()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        repeater?.invalidate()
        repeater = nil
    }
    
    private func setupViews() {
        // Setup the table view
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // Hide empty cells
        tableView.tableFooterView = UIView()
        
        // Setup navigation bar
        navigationItem.title = "Top \(RepositoryListViewModel.topLimit) Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
//    private func runRepeater() {
//        repeater = Timer.scheduledTimer(withTimeInterval: repeaterTimeInterval, repeats: true, block: { _ in
//            self.listViewModel.fetchData()
//        })
//    }
}

// MARK: - Table view data source
extension RepositoryListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RepositoryCell
        
        let viewModel = itemViewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - Table view delegate
extension RepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowItemViewModel = itemViewModels[indexPath.row]
        let repositoryFetcher = NetworkingService()
        let detailViewModel = RepositoryDetailViewModel(fetchingService: repositoryFetcher, rowItemViewModel: rowItemViewModel)
        let detailViewController = RepositoryDetailViewController(detailViewModel: detailViewModel)
        navigationController?.pushViewController(detailViewController, animated: true)
        
        // Deselect selected row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
