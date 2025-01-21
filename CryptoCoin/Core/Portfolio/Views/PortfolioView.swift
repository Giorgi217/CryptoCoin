//
//  PortfolioView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 13.01.25.
//

import UIKit
import SwiftUI

class PortfolioView: UIViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
    let chartView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themeKit.secondaryView
        view.layer.cornerRadius = 15
        return view
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
    
    let buyLabel = UILabel.createLabel(
        text: "Buy",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    
    let depositLabel = UILabel.createLabel(
        text: "Deposit",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    
    let withDraw = UILabel.createLabel(
        text: "Withdraw",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    
    let detailsLabel = UILabel.createLabel(
        text: "Other",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    let trendingLabel = UILabel.createLabel(
        text: "TrendingNow",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    let recommendedLabel = UILabel.createLabel(
        text: "Experts Recommendetion",
        font: UIFont.boldSystemFont(ofSize: 17),
        textColor: UIColor.themeKit.text)
    
    let buyButton = UIButton.circleButton(for: .plus)
    let depositButton = UIButton.circleButton(for: .wallet)
    let withdrawButton = UIButton.circleButton(for: .arrow)
    let detailsButton = UIButton.circleButton(for: .ellipsis)
    
    let trendingCollection = TrendingCollectionView()
    let recommendedCollection = RecommendedCollectionView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        view.backgroundColor = UIColor.themeKit.background
        
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
        depositButton.addTarget(self, action: #selector(depositButtonTapped), for: .touchUpInside)
        withdrawButton.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
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
        contentView.addSubview(buttonStackView)
        contentView.addSubview(trendingLabel)
        contentView.addSubview(trendingCollection)
        contentView.addSubview(recommendedLabel)
        contentView.addSubview(recommendedCollection)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        portfolioValue.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        trendingCollection.translatesAutoresizingMaskIntoConstraints = false
        trendingCollection.translatesAutoresizingMaskIntoConstraints = false
        recommendedLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendedCollection.translatesAutoresizingMaskIntoConstraints = false
        
        setupNavigationBar()
        setupConstraints()
        configuraStackView()
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
            
            buttonStackView.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 20),
            buttonStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            buttonStackView.heightAnchor.constraint(equalToConstant: 65),
            
            trendingLabel.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 25),
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
            
            recommendedCollection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configuraStackView() {
        let buttons = [buyButton, depositButton, withdrawButton, detailsButton]
        let labels = [buyLabel, depositLabel, withDraw, detailsLabel]
        
        for (button, label) in zip(buttons, labels) {
            let containerView = createButtonLabelContainer(button: button, label: label)
            buttonStackView.addArrangedSubview(containerView)
        }
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
    @objc func detailsButtonTapped() {
        print("SomeOne Tapped to Details Button")
        
        
    }
    
    @objc func depositButtonTapped() {
        navigationController?.pushViewController(AccountTransacionView(transactionType: .deposit), animated: true)
    }
    
    
    
    @objc func withdrawButtonTapped() {
        navigationController?.pushViewController(AccountTransacionView(transactionType: .withdraw), animated: true)
    }
}
