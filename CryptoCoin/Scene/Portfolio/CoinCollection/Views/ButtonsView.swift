//
//  ButtonsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 23.01.25.
//
import UIKit

protocol ButtonsViewDelegate: AnyObject {
    func buyButtonTapped()
    func depositButtonTapped()
    func withdrawButtonTapped()
    func detailsButtonTapped()
}

class ButtonsView: UIView {
    weak var delegate: ButtonsViewDelegate?
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let buyButton = UIButton.circleButton(for: .plus)
    private let depositButton = UIButton.circleButton(for: .wallet)
    private let withdrawButton = UIButton.circleButton(for: .arrow)
    private let detailsButton = UIButton.circleButton(for: .ellipsis)
    
    private let buyLabel = UILabel.createLabel(
        text: "Buy",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    
    private let depositLabel = UILabel.createLabel(
        text: "Deposit",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    
    private let withDraw = UILabel.createLabel(
        text: "Withdraw",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)
    
    private let detailsLabel = UILabel.createLabel(
        text: "Other",
        font: UIFont.systemFont(ofSize: 15),
        textColor: UIColor.themeKit.text)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configuraButtonsView()
        configureButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureButtonActions() {
        detailsButton.addTarget(self, action: #selector(detailsButtonTapped), for: .touchUpInside)
        depositButton.addTarget(self, action: #selector(depositButtonTapped), for: .touchUpInside)
        withdrawButton.addTarget(self, action: #selector(withdrawButtonTapped), for: .touchUpInside)
        buyButton.addTarget(self, action: #selector(buyButtonTapped), for: .touchUpInside)
    }
    
    private func configuraButtonsView() {
        configuraStackView()
        let buttons = [buyButton, depositButton, withdrawButton, detailsButton]
        let labels = [buyLabel, depositLabel, withDraw, detailsLabel]
        
        for (button, label) in zip(buttons, labels) {
            let containerView = createButtonLabelContainer(button: button, label: label)
            buttonStackView.addArrangedSubview(containerView)
        }
    }
    
    private func configuraStackView() {
        self.addSubview(buttonStackView)
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            buttonStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            buttonStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            buttonStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
        ])
    }
    
    private func createButtonLabelContainer(button: UIButton, label: UILabel) -> UIView {
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
    
    @objc private func detailsButtonTapped() {
        delegate?.detailsButtonTapped()
    }
    
    @objc private func depositButtonTapped() {
        delegate?.depositButtonTapped()
    }
    
    @objc private func withdrawButtonTapped() {
        delegate?.withdrawButtonTapped()
    }
    @objc private func buyButtonTapped() {
        delegate?.buyButtonTapped()
    }
}
