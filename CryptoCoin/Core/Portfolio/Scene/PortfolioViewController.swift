//
//  PortfolioView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI

class PortfolioViewController: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let chartView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themeKit.secondaryView
        view.layer.cornerRadius = 15
        return view
    }()
    
    let buttonsView = ButtonsView()
    
    let titleLabel = UILabel.createLabel(
        text: "Wallet",
        font: UIFont.boldSystemFont(ofSize: 20),
        textColor: UIColor.themeKit.text)
    
    let walletLabel = UILabel.createLabel(
        text: "Total portfolio value",
        font: UIFont.boldSystemFont(ofSize: 14),
        textColor: UIColor.themeKit.text)
    
    let portfolioValue = UILabel.createLabel(
        text: "100.34 $",
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
    
    let trendingCollection = TrendingCollectionView()
    let recommendedCollection = RecommendedCollectionView()
    
    let investmentView = InvestmentView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        buttonsView.delegate = self
        view.backgroundColor = UIColor.themeKit.background
        
        trendingCollection.viewController = self
        recommendedCollection.viewController = self
    }
    
    func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(walletLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(portfolioValue)
        contentView.addSubview(chartView)
        contentView.addSubview(buttonsView)
        contentView.addSubview(trendingLabel)
        contentView.addSubview(trendingCollection)
        contentView.addSubview(recommendedLabel)
        contentView.addSubview(recommendedCollection)
        contentView.addSubview(investmentView)
        
        trendingCollection.backgroundColor = UIColor.themeKit.background
        recommendedCollection.backgroundColor = UIColor.themeKit.background

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        portfolioValue.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        trendingCollection.translatesAutoresizingMaskIntoConstraints = false
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendedCollection.translatesAutoresizingMaskIntoConstraints = false
        investmentView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        
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
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            walletLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            walletLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            walletLabel.heightAnchor.constraint(equalToConstant: 15),
            
            portfolioValue.topAnchor.constraint(equalTo: walletLabel.bottomAnchor, constant: 10),
            portfolioValue.centerXAnchor.constraint(equalTo: walletLabel.centerXAnchor),
            portfolioValue.heightAnchor.constraint(equalToConstant: 25),
            
            chartView.topAnchor.constraint(equalTo: portfolioValue.bottomAnchor, constant: 20),
            chartView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            chartView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            chartView.heightAnchor.constraint(equalToConstant: 220),
            
            buttonsView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
            buttonsView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonsView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            buttonsView.heightAnchor.constraint(equalToConstant: 65),
            
            trendingLabel.topAnchor.constraint(equalTo: buttonsView.bottomAnchor, constant: 25),
            trendingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            trendingCollection.topAnchor.constraint(equalTo: trendingLabel.bottomAnchor),
            trendingCollection.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trendingCollection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trendingCollection.heightAnchor.constraint(equalToConstant: 150),
            
            
            recommendedLabel.topAnchor.constraint(equalTo: trendingCollection.bottomAnchor),
            recommendedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            recommendedCollection.topAnchor.constraint(equalTo: recommendedLabel.bottomAnchor),
            recommendedCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            recommendedCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            recommendedCollection.heightAnchor.constraint(equalToConstant: 150),
            
            investmentView.topAnchor.constraint(equalTo: recommendedCollection.bottomAnchor),
            investmentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            investmentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            investmentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            investmentView.heightAnchor.constraint(equalToConstant: 350),
            investmentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func createButtonLabelContainer(button: UIButton, label: UILabel) -> UIView {
        let containerView = UIView()
        containerView.addSubview(button)
        containerView.addSubview(label)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: containerView.topAnchor),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        return containerView
    }
    
    func setupNavigationBar() {
        let buttonImage = UIImage(systemName: "magnifyingglass")
        let barButton = UIBarButtonItem(
            image: buttonImage,
            style: .plain,
            target: self,
            action: #selector(buttonTapped))
        navigationItem.rightBarButtonItem = barButton
        navigationItem.titleView = titleLabel
    }
    
    @objc func buttonTapped() {
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
