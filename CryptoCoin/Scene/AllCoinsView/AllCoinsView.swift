//
//  AllCoinsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI

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
        viewModel.loadSearchedCoinsFromUserDefaults()
        setupUI()
        setupNavigationBar()
        viewModel.fetchData()
        setupViewModelBindings()
        setupNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
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
        coinsTableView.backgroundColor = UIColor.themeKit.background
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        NSLayoutConstraint.activate([
            coinsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            coinsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            coinsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            coinsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
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
    
    private func setupViewModelBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.coinsTableView.reloadData()
        }
        
        viewModel.onAlertDismissed = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        viewModel.onError = { [weak self] message in
            self?.viewModel.showAlert(message: message)
        }
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleCoinSelected(_:)), name: .coinSelectedNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(coinTapped(_:)), name: .coinTapped, object: nil)
    }
    
    @objc private func cancelButtonTapped() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc func handleCoinSelected(_ notification: Notification) {
        guard let searchedCoin = notification.userInfo?[NotificationKeys.selectedCoin] as? CoinModel else { return }
        if viewModel.coins.searchedCoins.firstIndex(where: { $0.id == searchedCoin.id }) != nil {
        } else {
            viewModel.coins.searchedCoins.insert(searchedCoin, at: 0)
            viewModel.saveSearchedCoinsToUserDefaults()
            coinsTableView.reloadData()
        }
    }
    
    @objc private func coinTapped(_ notification: Notification) {
        guard let coin = notification.object as? CoinModel else { return }
        
        let detailsView = CoinDetailsView(
            viewModel: CoinDetailsViewModel(coinId: coin.id ?? "", isHolding: false),
            chartViewModel: ChartViewModel(symbol: coin.id ?? "")
        )
        let hostingController = UIHostingController(rootView: detailsView)
        hostingController.view.backgroundColor = UIColor.themeKit.background
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
