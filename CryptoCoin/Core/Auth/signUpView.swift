//
//  signUpView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 27.01.25.
//

import UIKit

class signUpView: UIViewController {
    let viewModel = AuthViewModel()
    
    private let emailTextField = ReusableTextField()
    private let passwordTextField = ReusableTextField()
    private let confirmPasswordTextField = ReusableTextField()
   
    private let signUpLabel = UILabel.createLabel(text: "Sign Up", font: UIFont.boldSystemFont(ofSize: 25), textColor: UIColor.themeKit.text)
    private let emailLabel = UILabel.createLabel(text: "Email", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.themeKit.text)
    private let passwordLabel = UILabel.createLabel(text: "Password", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.themeKit.text)
    private let confirmPassword = UILabel.createLabel(text: "Confirm Password", font: UIFont.systemFont(ofSize: 15), textColor: UIColor.themeKit.text)
    
    private let SignUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeKit.blue
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.themeKit.background
        setupTextFields()
        setupLabel()
        SignUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
        
        confirmPasswordTextField.placeholder = "Confirm Password"
        confirmPasswordTextField.isSecure = true
        confirmPasswordTextField.frame = CGRect(x: 40, y: 398, width: 300, height: 44)
        view.addSubview(confirmPasswordTextField)
    }
    
    func setupLabel() {
        view.addSubview(signUpLabel)
        view.addSubview(emailLabel)
        view.addSubview(passwordLabel)
        view.addSubview(confirmPassword)
        view.addSubview(SignUpButton)
        
        NSLayoutConstraint.activate([
            signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: signUpLabel.topAnchor, constant: 85),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 25),
            passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            
            confirmPassword.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 25),
            confirmPassword.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            
            SignUpButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 50),
            SignUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            SignUpButton.heightAnchor.constraint(equalToConstant: 40),
            SignUpButton.widthAnchor.constraint(equalToConstant: 150)
            
        ])
    }
    
    @objc func signUpTapped() {
        let errorMessage = viewModel.validateSignUpInput(
            email: emailTextField.text,
            password: passwordTextField.text,
            confirmPassword: confirmPasswordTextField.text
        )
    
        if let errorMessage = errorMessage {
            showAlert(message: errorMessage)
            return
        }
        
        guard let password = passwordTextField.text,
              let email = emailTextField.text else {
            return
        }
        
        Task {
            do {
                try await viewModel.signUp(email: email, password: password)
                showAlert(message: "Sign-up successful!"){
                    let dashboardVC = LogInView()
                    dashboardVC.modalPresentationStyle = .fullScreen
                    self.navigationController?.pushViewController(dashboardVC, animated: true)
                }
            } catch {
                if let error = error as NSError? {
                    showAlert(message: error.localizedDescription)
                } else {
                    showAlert(message: "Something went Wrong, try again later.")
                }
            }
        }
    }
    
    
    private func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Notice", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
