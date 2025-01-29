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
    let useId = UserSessionManager.shared.userId
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let chartView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.themeKit.secondaryView
//        view.layer.cornerRadius = 15
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    let gainerLabel = UILabel.createLabel(
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
    
    let buttonsView: ButtonsView = {
       let buttonsView = ButtonsView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        return buttonsView
    }()
    
    let walletLabel = UILabel.createLabel(
        text: "Total portfolio value",
        font: UIFont.boldSystemFont(ofSize: 14),
        textColor: UIColor.themeKit.text)
    
    let portfolioValue = UILabel.createLabel(
        text: "",
        font: UIFont.boldSystemFont(ofSize: 25),
        textColor: UIColor.themeKit.text)
    
    let trendingLabel = UILabel.createLabel(
        text: "TrendingNow",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    
    let recommendedLabel = UILabel.createLabel(
        text: "Experts Recommendetion",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    
    let holdingLabel = UILabel.createLabel(
        text: "Holdings",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    
    let trendingCollection = TrendingCollectionView()
    let recommendedCollection = RecommendedCollectionView()
    let investmentView = InvestmentView()
    let investmentBalanceView = InvestmentBalanceView()
    
    let refreshControl = UIRefreshControl()
    
    //MARK: INIT
    
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
        
        buttonsView.delegate = self
        trendingCollection.viewController = self
        recommendedCollection.viewController = self
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        // Configure the refresh control
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        scrollView.refreshControl = refreshControl
        
        refreshData()
    }

    @objc func refreshData() {
        Task {
          let porfolio = try await viewModel.fetchMyPortfolio(userId: useId ?? "")
            
            guard let dayCoins = porfolio.dayCoinModel,
                  let allCoins = porfolio.allCoinModel,
                  let investedBalance = porfolio.investedBalance else {
                refreshControl.endRefreshing()
                return
            }
            investmentView.dayCoins = dayCoins
            investmentView.allCoins = allCoins
            investmentView.configure(dayCoins: dayCoins, allCoins: allCoins, investedBalance: investedBalance)
            investmentView.sumChange.text = porfolio.totalChangedBalance.asCurrencyWith2Decimals()
            
            investmentView.sumChangePrecentage.text = (porfolio.totalChangedBalance * 100 / (porfolio.investedBalance ?? 0)).asPercentString()
            portfolioValue.text = investedBalance.asCurrencyWith2Decimals()
            investmentBalanceView.balanceValueLabel.text = investedBalance.asCurrencyWith2Decimals()
            
            refreshControl.endRefreshing()
        }
    }

    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(walletLabel)
        contentView.addSubview(portfolioValue)
//        contentView.addSubview(chartView)
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
    
    func setupConstraints() {
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
            
//            chartView.topAnchor.constraint(equalTo: portfolioValue.bottomAnchor, constant: 20),
//            chartView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
//            chartView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            chartView.heightAnchor.constraint(equalToConstant: 220),
            
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

// MARK: ButtonsViewDelegate

extension PortfolioViewController: ButtonsViewDelegate {
    func depositButtonTapped() {
        navigationController?.pushViewController(AccountTransacionView(transactionType: .deposit), animated: true)
    }
    
    func withdrawButtonTapped() {
        navigationController?.pushViewController(AccountTransacionView(transactionType: .withdraw), animated: true)
    }
    
    func detailsButtonTapped() {
        print("SomeOne Tapped to Details Button")
    }
    
    func buyButtonTapped() {
        navigationController?.pushViewController(AllCoinsView(), animated: true)
    }
}

