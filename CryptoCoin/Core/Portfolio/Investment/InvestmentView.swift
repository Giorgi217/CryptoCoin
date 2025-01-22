//
//  InvestmentView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 19.01.25.
//

import UIKit

class InvestmentView: UIView {

    var viewModel: InvestmentViewModelProtocol

    // MARK: Init
    
    init(viewModel: InvestmentViewModelProtocol = InvestmentViewModel()) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.themeKit.secondaryView
        view.layer.cornerRadius = 12
        return view
    }()
    
    let investmentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chart.bar.xaxis.ascending.badge.clock")
        imageView.tintColor = .white
        imageView.contentMode = .center
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.green
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    let investmentStaticLabel = UILabel.createLabel(
        text: "My Investment",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.secondaryText,
        textAlignment: .center)
    
    let investmentTotalValueLabel = UILabel.createLabel(
        text: "20,119.00$",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text,
        textAlignment: .center)

    let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Day", "All"])
        control.selectedSegmentIndex = 1
        control.layer.cornerRadius = 6
        return control
    }()
    
    let sumLabel = UILabel.createLabel(
        text: "Daily Changes",
        font: UIFont.systemFont(ofSize: 12),
        textColor: UIColor.themeKit.secondaryText)
    
    let triangleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")
        return imageView
    }()
    
    let sumChangePrecentage = UILabel.createLabel(
        text: "2.26",
        font: UIFont.boldSystemFont(ofSize: 13) ,
        textColor: UIColor.green)
    
    let sumChange = UILabel.createLabel(
        text: "3904",
        font: UIFont.boldSystemFont(ofSize: 13) ,
        textColor: UIColor.themeKit.text)

    let investedTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.gray
        return tableView
    }()
    
    func configureInvestedTableView() {
        
        investedTableView.dataSource = self
        investedTableView.delegate = self
        
        investedTableView.register(AllCoinTableViewCell.self, forCellReuseIdentifier: "AllCoinTableViewCell")
    }

    
    private func setUp() {
        viewModel.fetchCoins()
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.themeKit.background
        setupUI()
        configureSegmentedControl()
        configureInvestedTableView()
    }
    
    func setupUI() {
        self.addSubview(conteinerView)
        conteinerView.addSubview(investmentImageView)
        conteinerView.addSubview(investmentStaticLabel)
        conteinerView.addSubview(investmentTotalValueLabel)
        conteinerView.addSubview(segmentedControl)
        conteinerView.addSubview(sumLabel)
        conteinerView.addSubview(sumChange)
        conteinerView.addSubview(triangleImageView)
        conteinerView.addSubview(sumChangePrecentage)
        conteinerView.addSubview(investedTableView)

        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        investmentImageView.translatesAutoresizingMaskIntoConstraints = false
        investmentStaticLabel.translatesAutoresizingMaskIntoConstraints = false
        investmentTotalValueLabel.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        sumLabel.translatesAutoresizingMaskIntoConstraints = false
        sumChange.translatesAutoresizingMaskIntoConstraints = false
        triangleImageView.translatesAutoresizingMaskIntoConstraints = false
        sumChangePrecentage.translatesAutoresizingMaskIntoConstraints = false
        investedTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        NSLayoutConstraint.activate([
            conteinerView.heightAnchor.constraint(equalToConstant: 350),
            conteinerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            conteinerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            investmentImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 15),
            investmentImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 15),
            investmentImageView.heightAnchor.constraint(equalToConstant: 40),
            investmentImageView.widthAnchor.constraint(equalTo: investmentImageView.heightAnchor),
            
            investmentStaticLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 15),
            investmentStaticLabel.leftAnchor.constraint(equalTo: investmentImageView.rightAnchor, constant: 15),
            
            investmentTotalValueLabel.topAnchor.constraint(equalTo: investmentStaticLabel.bottomAnchor, constant: 4),
            investmentTotalValueLabel.leftAnchor.constraint(equalTo: investmentImageView.rightAnchor, constant: 15),
            
            segmentedControl.topAnchor.constraint(equalTo: investmentImageView.topAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -15),
            segmentedControl.heightAnchor.constraint(equalToConstant: 27),
            segmentedControl.widthAnchor.constraint(equalToConstant: 100),
            
            sumLabel.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor),
            sumLabel.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            
            sumChange.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -15),
            sumChange.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 5),
            
            triangleImageView.leadingAnchor.constraint(equalTo: sumLabel.leadingAnchor, constant: -3),
            triangleImageView.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 5),
            triangleImageView.heightAnchor.constraint(equalToConstant: 16),
            triangleImageView.widthAnchor.constraint(equalToConstant: 11),
            
            sumChangePrecentage.leadingAnchor.constraint(equalTo: triangleImageView.trailingAnchor, constant: 3),
            sumChangePrecentage.topAnchor.constraint(equalTo: sumLabel.bottomAnchor, constant: 5),
            
            investedTableView.topAnchor.constraint(equalTo: sumChangePrecentage.bottomAnchor, constant: 10),
            investedTableView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            investedTableView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            investedTableView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
    }
    
    func configureSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Day selected")
        } else {
            print("All selected")
        }
    }
}

extension InvestmentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = investedTableView.dequeueReusableCell(withIdentifier: "AllCoinTableViewCell") as? AllCoinTableViewCell else {
            return UITableViewCell()
        }
        let currentCoin = viewModel.coins[indexPath.row]
        cell.configure(with: currentCoin)
        return cell
    }
}
