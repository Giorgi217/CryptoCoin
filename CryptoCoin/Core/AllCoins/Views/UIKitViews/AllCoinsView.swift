//
//  AllCoinsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit

class AllCoinsView: UIViewController {
    let viewModel = AllCoinViewModel()
    let searchBar = UISearchBar()
    let coinsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.themeKit.background
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        fetchData()
        viewModel.onAlertDismissed = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        viewModel.onError = { [weak self] message in
            self?.viewModel.showAlert(message: message)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.themeKit.background
        view.addSubview(coinsTableView)
        configureTableView()
        setupSearchBarInNavigationBar()
    }
    
    private func configureTableView() {
        coinsTableView.dataSource = self
        coinsTableView.delegate = self
        coinsTableView.translatesAutoresizingMaskIntoConstraints = false
        coinsTableView.register(AllCoinTableViewCell.self, forCellReuseIdentifier: "AllCoinTableViewCell")
        coinsTableView.register(HoldingCoinsTableViewCell.self, forCellReuseIdentifier: "HoldingCoinsTableViewCell")
        coinsTableView.backgroundColor = .backgroundcolor
        
        NSLayoutConstraint.activate([
            coinsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            coinsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            coinsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            coinsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func fetchData() {
        print("\(viewModel.isLoading)")
        guard !viewModel.isLoading else { return }
        
        print("fetching stated.........")
        viewModel.isLoading = true
        Task {
            await viewModel.loadCoins()
            self.viewModel.isLoading = false
            DispatchQueue.main.async {
                self.coinsTableView.reloadData()
            }
        }
    }
    
    private func setupSearchBarInNavigationBar() {
        searchBar.placeholder = "Search here..."
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.searchBarStyle = .minimal
        navigationItem.titleView = searchBar
    }
    
    private func setupNavigationBar() {
        navigationItem.hidesBackButton = true
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        cancelButton.tintColor = UIColor.themeKit.secondaryText
        navigationItem.rightBarButtonItem = cancelButton
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
}
