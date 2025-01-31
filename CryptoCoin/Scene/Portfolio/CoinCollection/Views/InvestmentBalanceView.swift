//
//  InvestmentBalanceView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//

import UIKit


class InvestmentBalanceView: UIView {
    let conteinerBalanceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themeKit.secondaryView
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let balanceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "wallet.bifold")
        imageView.tintColor = .white
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.themeKit.secondary
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let balanceLabel = UILabel.createLabel(
        text: "Balance",
        font: UIFont.systemFont(ofSize: 13),
        textColor: UIColor.themeKit.secondaryText)
    
    let balanceValueLabel = UILabel.createLabel(
        text: "20 000 $",
        font: UIFont.boldSystemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(conteinerBalanceView)
        conteinerBalanceView.addSubview(balanceImageView)
        conteinerBalanceView.addSubview(balanceLabel)
        conteinerBalanceView.addSubview(balanceValueLabel)
        
        NSLayoutConstraint.activate([
            conteinerBalanceView.topAnchor.constraint(equalTo: self.topAnchor),
            conteinerBalanceView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            conteinerBalanceView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            conteinerBalanceView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            balanceImageView.centerYAnchor.constraint(equalTo: conteinerBalanceView.centerYAnchor),
            balanceImageView.leadingAnchor.constraint(equalTo: conteinerBalanceView.leadingAnchor, constant: 20),
            balanceImageView.widthAnchor.constraint(equalToConstant: 40),
            balanceImageView.widthAnchor.constraint(equalTo: balanceImageView.heightAnchor),
            
            balanceLabel.topAnchor.constraint(equalTo: balanceImageView.topAnchor),
            balanceLabel.leadingAnchor.constraint(equalTo: balanceImageView.trailingAnchor, constant: 20),
            
            balanceValueLabel.leadingAnchor.constraint(equalTo: balanceLabel.leadingAnchor),
            balanceValueLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor, constant: 3)
        ])
    }
    
    func configure(with balance: String) {
        balanceValueLabel.text = balance
    }
}

