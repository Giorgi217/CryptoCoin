//
//  LogInView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 27.01.25.
//

import UIKit

class LogInView: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    private let emailTextField = ReusableTextField()
    private let passwordTextField = ReusableTextField()
    
    private let signUpLabel = UILabel.createLabel(text: "Log In", font: UIFont.boldSystemFont(ofSize: 25), textColor: UIColor.themeKit.text)
    private let emailLabel = UILabel.createLabel(text: "Email", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.themeKit.text)
    private let passwordLabel = UILabel.createLabel(text: "Password", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.themeKit.text)
    
    
    private let SignInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeKit.blue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let SignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.themeKit.blue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor.themeKit.background
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let resetPasswod: UIButton = {
        let button = UIButton()
        button.setTitle("Resset Password", for: .normal)
        button.setTitleColor(UIColor.themeKit.secondaryText, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.backgroundColor = UIColor.themeKit.background
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.themeKit.background
        setupTextFields()
        setupLabel()
        setupButtons()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupTextFields() {
        emailTextField.placeholder = "Your Email"
        emailTextField.isSecure = false
        emailTextField.frame = CGRect(x: 40, y: 210, width: 300, height: 44)
        view.addSubview(emailTextField)
        
        passwordTextField.placeholder = "Password"
        passwordTextField.isSecure = true
        passwordTextField.frame = CGRect(x: 40, y: 304, width: 300, height: 44)
        view.addSubview(passwordTextField)
    }
    
    private func setupLabel() {
        view.addSubview(signUpLabel)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)

        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: signUpLabel.topAnchor, constant: 85),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
        ])
    }
    
    private func setupButtons() {
        view.addSubview(SignUpButton)
        view.addSubview(resetPasswod)
        view.addSubview(SignInButton)
       
        
        SignUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        SignInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        resetPasswod.addTarget(self, action: #selector(resetPasswordTapped), for: .touchUpInside)

        
        NSLayoutConstraint.activate([
            SignUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            SignUpButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            
            resetPasswod.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            resetPasswod.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            
            SignInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 85),
            SignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            SignInButton.heightAnchor.constraint(equalToConstant: 40),
            SignInButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    
    @objc private func signUpTapped() {
        navigationController?.pushViewController(signUpView(), animated: true)
    }
    
    @objc private func signInTapped() {
        let errorMessage = viewModel.validateLogInInput(
            email: emailTextField.text,
            password: passwordTextField.text
        )
        
        if let errorMessage = errorMessage {
            showAlert(message: errorMessage)
            return
        }
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        Task {
            do {
                try await viewModel.logIn(email: email, password: password)
                print("Login successful!")
                navigationController?.pushViewController(PortfolioViewController(), animated: true)
            } catch {
                if let error = error as NSError? {
                    showAlert(message: error.localizedDescription)
                } else {
                    showAlert(message: "An unknown error occurred.")
                }
            }
        }
    }
    
    @objc private func resetPasswordTapped() {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        
        Task {
            do {
                try await viewModel.sendPasswordReset(email: email)
                showAlert(message: "Password reset email sent.")
            } catch {
                if let error = error as NSError? {
                    showAlert(message: error.localizedDescription)
                } else {
                    showAlert(message: "An unknown error occurred.")
                }
            }
        }
    }


    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

