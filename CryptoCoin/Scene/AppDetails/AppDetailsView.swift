//
//  AppDetailsView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import UIKit

class AppDetailsView: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "App Details"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.themeKit.text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to the Coin Portfolio App! Here you can check, buy, and manage your invested coins. Explore the world of cryptocurrencies."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor.themeKit.text
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let likeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        button.tintColor = .systemPink
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        
        return button
    }()

    private let privacyPolicyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Privacy Policy", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.systemBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }

    private func setupView() {
        view.backgroundColor = UIColor.themeKit.background
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(likeButton)
        view.addSubview(privacyPolicyButton)

        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        privacyPolicyButton.addTarget(self, action: #selector(openPrivacyPolicy), for: .touchUpInside)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            likeButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 40),
            likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            likeButton.widthAnchor.constraint(equalToConstant: 70),
            likeButton.heightAnchor.constraint(equalToConstant: 70),

            privacyPolicyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            privacyPolicyButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -250)
        ])
    }

    @objc private func likeButtonTapped() {
        likeButton.isSelected.toggle()
        if likeButton.isSelected {
            animateHeartExplosion()
        }
    }

    @objc private func openPrivacyPolicy() {
        if let url = URL(string: "https://www.example.com/privacy-policy") {
            UIApplication.shared.open(url)
        }
    }

    private func animateHeartExplosion() {
        UIView.animate(withDuration: 0.2, animations: {
            self.likeButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            self.createExplosionEffect(at: self.likeButton.center)

            UIView.animate(withDuration: 0.2) {
                self.likeButton.transform = CGAffineTransform.identity
            }
        }
    }

    private func createExplosionEffect(at position: CGPoint) {
        let explosionSize: CGFloat = 30
        let numberOfParticles = 15

        for _ in 0..<numberOfParticles {
            let particle = UIView()
            particle.backgroundColor = .systemPink
            particle.layer.cornerRadius = explosionSize / 2
            particle.frame = CGRect(x: position.x, y: position.y, width: explosionSize, height: explosionSize)
            view.addSubview(particle)

            let randomX = CGFloat.random(in: -100...100)
            let randomY = CGFloat.random(in: -100...100)
            let endPoint = CGPoint(x: position.x + randomX, y: position.y + randomY)

            UIView.animate(withDuration: 0.5, animations: {
                particle.center = endPoint
                particle.alpha = 0
                particle.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }) { _ in
                particle.removeFromSuperview()
            }
        }
    }
}
