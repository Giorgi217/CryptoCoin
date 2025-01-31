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
        setupUI()
        setupNavigationBar()
        fetchData()
        loadSearchedCoinsFromUserDefaults()
        viewModel.onAlertDismissed = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        viewModel.onError = { [weak self] message in
            self?.viewModel.showAlert(message: message)
        }
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleCoinSelected(_:)),
            name: .coinSelectedNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(self, selector: #selector(coinTapped(_:)), name: .coinTapped, object: nil)
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
        coinsTableView.backgroundColor = .backgroundcolor
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        NSLayoutConstraint.activate([
            coinsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            coinsTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            coinsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            coinsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func fetchData() {
        guard !viewModel.isLoading else { return }
        
        viewModel.isLoading = true
        Task {
            await viewModel.loadCoins()
            self.viewModel.isLoading = false
            DispatchQueue.main.async {
                self.viewModel.filteredCoins = self.viewModel.coins.allCoins
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
    
    @objc func handleCoinSelected(_ notification: Notification) {
        guard let searchedCoin = notification.userInfo?[NotificationKeys.selectedCoin] as? CoinModel else { return }
        if viewModel.coins.searchedCoins.firstIndex(where: { $0.id == searchedCoin.id }) != nil {
            
        } else {
            viewModel.coins.searchedCoins.insert(searchedCoin, at: 0)
            saveSearchedCoinsToUserDefaults()
            coinsTableView.reloadData()
        }
    }
    
    private func saveSearchedCoinsToUserDefaults() {
        let coinsTosave = Array(viewModel.coins.searchedCoins.prefix(6))
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(coinsTosave)
            UserDefaults.standard.set(data, forKey: "searchedCoins")
        } catch {
            print("Failed to save searched coins to UserDefaults: \(error)")
        }
    }
    
    private func loadSearchedCoinsFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "searchedCoins") {
            do {
                let decoder = JSONDecoder()
                let savedCoins = try decoder.decode([CoinModel].self, from: data)
                viewModel.coins.searchedCoins = savedCoins
                coinsTableView.reloadData()
            } catch {
                print("Failed to load searched coins from UserDefaults: \(error)")
            }
        }
    }
    
    @objc private func coinTapped(_ notification: Notification) {
        guard let coin = notification.object as? CoinModel else { return }
        
        let detailsView = CoinDetailsView(
            viewModel: CoinDetailsViewModel(coinId: coin.id ?? "", isHolding: false),
            chartViewModel: ChartViewModel(symbol: coin.symbol ?? "")
        )

        let hostingController = UIHostingController(rootView: detailsView)
        hostingController.view.backgroundColor = UIColor.themeKit.background
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
