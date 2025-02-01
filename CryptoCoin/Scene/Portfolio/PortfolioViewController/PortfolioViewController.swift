//
//  PortfolioView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI
import FirebaseFirestore

class PortfolioViewController: UIViewController {
    var viewModel: PortfolioViewModelProtocol
    private let useId = UserSessionManager.shared.userId
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let gainerLabel = UILabel.createLabel(
        text: "Gainer Coins",
        font: UIFont.boldSystemFont(ofSize: 18),
        textColor: UIColor.themeKit.text)
    
    private lazy var gainerCoinsView: UIView = {
        let hostingController = UIHostingController(rootView: GainerCoinsView())
        addChild(hostingController)
        let view = hostingController.view!
        view.backgroundColor = UIColor.themeKit.background
        view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.didMove(toParent: self)
        return view
    }()
    
    private let buttonsView: ButtonsView = {
        let buttonsView = ButtonsView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()
    
    private let walletLabel = UILabel.createLabel(
        text: "Total portfolio value",
        font: UIFont.boldSystemFont(ofSize: 14),
        textColor: UIColor.themeKit.text)
    
    private let portfolioValue = UILabel.createLabel(
        text: "",
        font: UIFont.boldSystemFont(ofSize: 25),
        textColor: UIColor.themeKit.text)
    
    private let trendingLabel = UILabel.createLabel(
        text: "TrendingNow",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    
    private let recommendedLabel = UILabel.createLabel(
        text: "Experts Recommendetion",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    
    private let holdingLabel = UILabel.createLabel(
        text: "Holdings",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    
    private let trendingCollection = TrendingCollectionView()
    private let recommendedCollection = RecommendedCollectionView()
    private let investmentView = InvestmentView()
    private let investmentBalanceView = InvestmentBalanceView()
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: PortfolioViewModelProtocol = PortfolioViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()  {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor.themeKit.background
        setupDelegate()
        setupNavigationAndRefreshHandling()
        refreshData()
    }
    
    private func setupNavigationAndRefreshHandling() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshContent), name: .transactionCompleted, object: nil)
    }
    
    private func setupDelegate() {
        buttonsView.delegate = self
        trendingCollection.viewController = self
        recommendedCollection.viewController = self
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .transactionCompleted, object: nil)
    }
    
    @objc func refreshData() {
        Task {
            let porfolio = try await viewModel.fetchMyPortfolio(userId: useId ?? "")
            refreshControl.endRefreshing()
            guard let dayCoins = porfolio.dayCoinModel,
                  let allCoins = porfolio.allCoinModel,
                  let investedBalance = porfolio.investedBalance,
                  let userBalance = porfolio.userBalance else {
                return
            }
            investmentView.dayCoins = dayCoins
            investmentView.allCoins = allCoins
            investmentView.configure(dayCoins: dayCoins, allCoins: allCoins, investedBalance: investedBalance)
            let sumPercentage = porfolio.totalChangedBalance * 100 / (porfolio.investedBalance ?? 0)
            investmentView.configureSum(sum: porfolio.totalChangedBalance, sumPercent: sumPercentage)
            portfolioValue.text = (investedBalance + userBalance).asCurrencyWith2Decimals()
            investmentBalanceView.balanceValueLabel.text = userBalance.asCurrencyWith2Decimals()
            refreshControl.endRefreshing()
        }
    }
    
    @objc func refreshContent() {
        refreshData()
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(walletLabel)
        contentView.addSubview(portfolioValue)
        contentView.addSubview(gainerLabel)
        contentView.addSubview(gainerCoinsView)
        contentView.addSubview(buttonsView)
        contentView.addSubview(trendingLabel)
        contentView.addSubview(trendingCollection)
        contentView.addSubview(recommendedLabel)
        contentView.addSubview(recommendedCollection)
        contentView.addSubview(investmentBalanceView)
        contentView.addSubview(holdingLabel)
        contentView.addSubview(investmentView)
        
        setupNavigationBar()
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            walletLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            walletLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            walletLabel.heightAnchor.constraint(equalToConstant: 15),
            
            portfolioValue.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 10),
            portfolioValue.centerXAnchor.constraint(equalTo: walletLabel.centerXAnchor),
            portfolioValue.heightAnchor.constraint(equalToConstant: 25),
            
            gainerLabel.topAnchor.constraint(equalTo: portfolioValue.bottomAnchor, constant: 40),
            gainerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            gainerCoinsView.topAnchor.constraint(equalTo: gainerLabel.bottomAnchor, constant: 15),
            gainerCoinsView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            gainerCoinsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            gainerCoinsView.heightAnchor.constraint(equalToConstant: 190),
            
            buttonsView.topAnchor.constraint(equalTo: gainerCoinsView.bottomAnchor, constant: 40),
            buttonsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 65),
            
            trendingLabel.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 50),
            trendingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            trendingCollection.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor),
            trendingCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trendingCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            trendingCollection.heightAnchor.constraint(equalToConstant: 150),
            
            
            recommendedLabel.topAnchor.constraint(equalTo: trendingCollection.bottomAnchor),
            recommendedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            recommendedCollection.topAnchor.constraint(equalTo: recommendedLabel.bottomAnchor),
            recommendedCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendedCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendedCollection.heightAnchor.constraint(equalToConstant: 150),
            
            investmentBalanceView.topAnchor.constraint(equalTo: recommendedCollection.bottomAnchor, constant: 15),
            investmentBalanceView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            investmentBalanceView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            investmentBalanceView.heightAnchor.constraint(equalToConstant: 77),
            
            holdingLabel.topAnchor.constraint(equalTo: investmentBalanceView.bottomAnchor, constant: 25),
            holdingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            investmentView.topAnchor.constraint(equalTo: holdingLabel.bottomAnchor, constant: 10),
            investmentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            investmentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            investmentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            investmentView.heightAnchor.constraint(equalToConstant: 350),
            investmentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        let buttonImage = UIImage(systemName: "magnifyingglass")
        let barButton = UIBarButtonItem(
            image: buttonImage,
            style: .plain,
            target: self,
            action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = barButton
        title = "Wallet"
        navigationItem.hidesBackButton = true
    }
    
    @objc func searchButtonTapped() {
        navigationController?.pushViewController(AllCoinsView(), animated: true)
    }
}

extension PortfolioViewController: ButtonsViewDelegate {
    func depositButtonTapped() {
        navigationController?.pushViewController(AccountTransacionView(transactionType: .deposit), animated: true)
    }
    
    func withdrawButtonTapped() {
        navigationController?.pushViewController(AccountTransacionView(transactionType: .withdraw), animated: true)
    }
    
    func detailsButtonTapped()  {
        print("SomeOne Tapped to Details Button")
    }
    
    func buyButtonTapped() {
        navigationController?.pushViewController(AllCoinsView(), animated: true)
    }
}

