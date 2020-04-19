//
//  RepositoriesViewController.swift
//  TopRepos
//
//  Created by Stepan Vardanyan on 17.01.20.
//  Copyright © 2020 Stepan Vardanyan. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    fileprivate let tableView = UITableView()
    
    fileprivate let cellIdentifier = "cell"
    
    fileprivate let fetchingService: RepositoryFetcher!
    
    private var viewModels = [RepositoryViewModel]()
    
    private var repeater: Timer?
    private var repeaterTimeInterval: TimeInterval = 5
    
    // Set the top limitation here.
    // Please note that GitHub sets some limitations regarding the number of results per request. Use pagination for big numbers.
    fileprivate let topLimit = 20
    
    
    init(fetchingService: RepositoryFetcher) {
        self.fetchingService = fetchingService
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
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Run repeater to refetch the data
        runRepeater()
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
        navigationItem.title = "Top \(topLimit) Repositories"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func runRepeater() {
        repeater = Timer.scheduledTimer(withTimeInterval: repeaterTimeInterval, repeats: true, block: { _ in
            self.fetchData()
        })
    }
    
    private func fetchData() {
        
        fetchingService.getRepositories(request: SearchRequest(.mostPopular(topLimit))) {  [weak self] result in
            
            switch result {
            case .success(let response):
                self?.updateTableView(with: response.items)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateTableView(with items: [Repository]) {
        self.viewModels = items.map {
            RepositoryViewModel(repository: $0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.reloadData()
            //            print("Repository List Reloaded")
        }
    }
}

// MARK: - Table view data source
extension RepositoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! RepositoryCell
        
        let viewModel = viewModels[indexPath.row]
        cell.configure(with: viewModel)
        
        return cell
    }
}

// MARK: - Table view delegate
extension RepositoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // I'd use coordinator pattern for real projects
        let viewModel = viewModels[indexPath.row]
        let detailViewController = RepositoryDetailViewController(viewModel: viewModel, fetchingService: self.fetchingService)
        navigationController?.pushViewController(detailViewController, animated: true)
        
        // Deselect selected row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
