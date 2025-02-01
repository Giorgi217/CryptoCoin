//
//  AccountTransacionView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 19.01.25.
//

import UIKit
import SwiftUI


class AccountTransacionView: UIViewController {
    let viewModel: AccountTransacionViewModelProtocol?
    let transactionType: TransactionType
    
    let transactionLabel = UILabel()
    let sourceAccountLabel = UILabel()
    let sourceView = UIView()
    let sourceImageView = UIImageView()
    let sourceLabel = UILabel()
    let startingBalanceLabel = UILabel()
    let divider = UIView()
    
    let targetAccountLabel = UILabel()
    let targetView = UIView()
    let targetImageView = UIImageView()
    let targetLabel = UILabel()
    let targetBalanceLabel = UILabel()
    
    let transactionView = UIView()
    let transactionTextField = UITextField()
    let transactionImageView = UIImageView()
    
    let transactionDivider = UIView()
    
    let actionButton = UIButton()
    
    func observers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    func fetchData() {
        Task {
            let myBalance = try await viewModel?.fetchMyBalance(userId: UserSessionManager.shared.userId ?? "")
            let myCardBalance = try await viewModel?.fetchCardMyBalance(userId: UserSessionManager.shared.userId ?? "")
            if transactionType == .deposit {
                startingBalanceLabel.text = myCardBalance?.asNumberString()
                targetBalanceLabel.text = myBalance?.asNumberString()
            } else {
                targetBalanceLabel.text = myCardBalance?.asNumberString()
                startingBalanceLabel.text = myBalance?.asNumberString()
            }
        }
    }
    
    init(transactionType: TransactionType, viewModel: AccountTransacionViewModelProtocol = AccountTransacionViewModel()) {
        self.transactionType = transactionType
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.backgroundcolor
        setupUI()
        observers()
        fetchData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        adjustForKeyboard(notification: notification, isShowing: true)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        adjustForKeyboard(notification: notification, isShowing: false)
    }
    
    private func adjustForKeyboard(notification: Notification, isShowing: Bool) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        let keyboardHeight = isShowing ? keyboardFrame.height : 25
        UIView.animate(withDuration: animationDuration) {
            self.actionButton.transform = CGAffineTransform(translationX: 0, y: -keyboardHeight + 40)
        }
    }
    
    @objc func buttonTapped() {
        let userId = UserSessionManager.shared.userId ?? ""
        let amounttext = transactionTextField.text ?? ""
        let amount = Double(amounttext) ?? 0
        Task{
            let cardBalance = try await viewModel?.fetchCardMyBalance(userId: userId) ?? 0
            if  transactionType == .deposit {
                Task {
                    if cardBalance >= amount {
                        try await viewModel?.withowMyCardBalance(userId: userId, balance: amount)
                        showAlert(title: "Done", message: "Transaction Proccessed")
                    } else {
                        transactionDivider.backgroundColor = UIColor.red
                        transactionTextField.placeholder = "Fill valid Amount"
                        transactionTextField.text = ""
                        transactionTextField.tintColor = UIColor.red
                    }
                }
            } else {
                Task {
                    let myBalance = try await viewModel?.fetchMyBalance(userId: UserSessionManager.shared.userId ?? "")
                    if myBalance ?? 0 >= amount {
                        try await viewModel?.fillMyCardBalance(userId: userId, balance: amount)
                        showAlert(title: "Done", message: "Transaction Proccessed")
                    } else {
                        transactionDivider.backgroundColor = UIColor.red
                        transactionTextField.placeholder = "Fill valid Amount"
                        transactionTextField.text = ""
                        transactionTextField.tintColor = UIColor.red
                    }
                }
            }
        }
    }

    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            
            let nextVC = PortfolioViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        transactionLabel.text = transactionType == .deposit ? "Deposit" : "WithDraw"
        transactionLabel.font = UIFont.boldSystemFont(ofSize: 25)
        transactionLabel.textColor = UIColor.themeKit.text
        transactionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transactionLabel)
        
        sourceAccountLabel.text = "From"
        sourceAccountLabel.font = UIFont.systemFont(ofSize: 13)
        sourceAccountLabel.textColor = UIColor.themeKit.secondaryText
        sourceAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sourceAccountLabel)
        
        sourceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sourceView)
        
        sourceImageView.image = UIImage(systemName: transactionType == .deposit ? "creditcard.fill" : "dollarsign.square.fill")
        sourceImageView.tintColor = UIColor.themeKit.text
        sourceImageView.translatesAutoresizingMaskIntoConstraints = false
        sourceView.addSubview(sourceImageView)
        
        sourceLabel.text = transactionType == .deposit ? "GE92***0187" : "TBYJOO167"
        sourceLabel.font = UIFont.systemFont(ofSize: 13)
        sourceLabel.textColor = UIColor.themeKit.secondaryText
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceView.addSubview(sourceLabel)
        
        startingBalanceLabel.text = "0.00"
        startingBalanceLabel.font = UIFont.systemFont(ofSize: 14)
        startingBalanceLabel.textColor = UIColor.themeKit.secondaryText
        startingBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        sourceView.addSubview(startingBalanceLabel)
        
        divider.backgroundColor = UIColor.separator
        divider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(divider)
        
        targetAccountLabel.text = "To:"
        targetAccountLabel.font = UIFont.systemFont(ofSize: 13)
        targetAccountLabel.textColor = UIColor.themeKit.secondaryText
        targetAccountLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(targetAccountLabel)
        
        targetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(targetView)
        
        targetImageView.image = UIImage(systemName: transactionType == .deposit ? "dollarsign.square.fill" : "creditcard.fill")
        targetImageView.tintColor = UIColor.themeKit.text
        targetImageView.translatesAutoresizingMaskIntoConstraints = false
        targetView.addSubview(targetImageView)
        
        targetLabel.text = transactionType == .deposit ? "TBYJOO167" : "GE92***0187"
        targetLabel.font = UIFont.systemFont(ofSize: 13)
        targetLabel.textColor = UIColor.themeKit.secondaryText
        targetLabel.translatesAutoresizingMaskIntoConstraints = false
        targetImageView.addSubview(targetLabel)
        
        targetBalanceLabel.text = "0.00"
        targetBalanceLabel.font = UIFont.systemFont(ofSize: 14)
        targetBalanceLabel.textColor = UIColor.themeKit.secondaryText
        targetBalanceLabel.translatesAutoresizingMaskIntoConstraints = false
        targetView.addSubview(targetBalanceLabel)
        
        transactionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(transactionView)
        
        transactionTextField.placeholder = "Amount"
        transactionTextField.keyboardType = .numberPad
        transactionTextField.translatesAutoresizingMaskIntoConstraints = false
        transactionTextField.delegate = self
        transactionView.addSubview(transactionTextField)
        
        transactionImageView.image = UIImage(systemName: "dollarsign")
        transactionView.addSubview(transactionImageView)
        transactionImageView.tintColor = UIColor.themeKit.secondaryText
        transactionImageView.translatesAutoresizingMaskIntoConstraints = false
        
        transactionDivider.backgroundColor = UIColor.separator
        transactionDivider.translatesAutoresizingMaskIntoConstraints = false
        transactionView.addSubview(transactionDivider)
        
        actionButton.setTitle(transactionType == .deposit ? "Deposit" : "Withdraw", for: .normal)
        actionButton.backgroundColor = UIColor.themeKit.blue
        actionButton.layer.cornerRadius = 15
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        view.addSubview(actionButton)
        
        NSLayoutConstraint.activate([
            transactionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            transactionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            sourceAccountLabel.topAnchor.constraint(equalTo: transactionLabel.bottomAnchor, constant: 20),
            sourceAccountLabel.leadingAnchor.constraint(equalTo: transactionLabel.leadingAnchor),
            
            sourceView.topAnchor.constraint(equalTo: sourceAccountLabel.bottomAnchor, constant: 10),
            sourceView.leadingAnchor.constraint(equalTo: sourceAccountLabel.leadingAnchor),
            sourceView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sourceView.heightAnchor.constraint(equalToConstant: 50),
            
            sourceImageView.leftAnchor.constraint(equalTo: sourceView.leftAnchor),
            sourceImageView.centerYAnchor.constraint(equalTo: sourceView.centerYAnchor),
            sourceImageView.heightAnchor.constraint(equalToConstant: 40),
            sourceImageView.widthAnchor.constraint(equalToConstant: 60),
            
            sourceLabel.centerYAnchor.constraint(equalTo: sourceImageView.centerYAnchor, constant: 5),
            sourceLabel.leftAnchor.constraint(equalTo: sourceImageView.rightAnchor, constant: 10),
            
            startingBalanceLabel.centerYAnchor.constraint(equalTo: sourceView.centerYAnchor),
            startingBalanceLabel.trailingAnchor.constraint(equalTo: sourceView.trailingAnchor, constant: -10),
            
            divider.heightAnchor.constraint(equalToConstant: 1),
            divider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            divider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            divider.topAnchor.constraint(equalTo: sourceView.bottomAnchor, constant: 20),
            
            targetAccountLabel.leadingAnchor.constraint(equalTo: sourceAccountLabel.leadingAnchor),
            targetAccountLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 20),
            
            targetView.topAnchor.constraint(equalTo: targetAccountLabel.bottomAnchor, constant: 10),
            targetView.leadingAnchor.constraint(equalTo: sourceView.leadingAnchor),
            targetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            targetView.heightAnchor.constraint(equalToConstant: 50),
            
            targetImageView.leftAnchor.constraint(equalTo: targetView.leftAnchor),
            targetImageView.centerYAnchor.constraint(equalTo: targetView.centerYAnchor),
            targetImageView.heightAnchor.constraint(equalToConstant: 40),
            targetImageView.widthAnchor.constraint(equalToConstant: 60),
            
            targetLabel.centerYAnchor.constraint(equalTo: targetImageView.centerYAnchor, constant: 5),
            targetLabel.leftAnchor.constraint(equalTo: targetImageView.rightAnchor, constant: 10),
            
            targetBalanceLabel.centerYAnchor.constraint(equalTo: targetView.centerYAnchor),
            targetBalanceLabel.trailingAnchor.constraint(equalTo: targetView.trailingAnchor, constant: -10),
            
            transactionView.topAnchor.constraint(equalTo: targetView.bottomAnchor, constant: 40),
            transactionView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor),
            transactionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            transactionView.heightAnchor.constraint(equalToConstant: 40),
            
            transactionTextField.leadingAnchor.constraint(equalTo: transactionView.leadingAnchor, constant: 5),
            transactionTextField.trailingAnchor.constraint(equalTo: transactionView.trailingAnchor, constant: -30),
            transactionTextField.centerYAnchor.constraint(equalTo: transactionView.centerYAnchor),
            transactionTextField.heightAnchor.constraint(equalToConstant: 20),
            
            transactionImageView.trailingAnchor.constraint(equalTo: transactionView.trailingAnchor, constant: -5),
            transactionImageView.centerYAnchor.constraint(equalTo: transactionTextField.centerYAnchor),
            transactionImageView.heightAnchor.constraint(equalTo: transactionView.heightAnchor, multiplier: 1/3),
            transactionImageView.widthAnchor.constraint(equalToConstant: 10),
            
            transactionDivider.topAnchor.constraint(equalTo: transactionTextField.bottomAnchor, constant: 3),
            transactionDivider.leadingAnchor.constraint(equalTo: transactionTextField.leadingAnchor),
            transactionDivider.trailingAnchor.constraint(equalTo: transactionImageView.trailingAnchor),
            transactionDivider.heightAnchor.constraint(equalToConstant: 1),
            
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension AccountTransacionView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
    }
}
