//
//  ReusableCollectionView.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 21.01.25.
//

import UIKit
import SwiftUI

class ReusableCollectionView<T: Hashable, Cell: UICollectionViewCell>: UIView, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let collectionView: UICollectionView
    var items: [T] = []
    var configureCell: ((Cell, T) -> Void)?
    var cellSelected: ((T) -> Void)?
    var viewController: UIViewController?
    
    init(layout: UICollectionViewLayout = UICollectionViewFlowLayout(), itemSize: CGSize) {
        let flowLayout = layout as? UICollectionViewFlowLayout
        flowLayout?.scrollDirection = .horizontal
        flowLayout?.itemSize = itemSize
        flowLayout?.minimumLineSpacing = 10
        flowLayout?.minimumInteritemSpacing = 10
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func register(cellType: Cell.Type) {
        collectionView.register(cellType, forCellWithReuseIdentifier: String(describing: cellType))
    }
    
    func setItems(_ newItems: [T]) {
        self.items = newItems
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: Cell.self), for: indexPath) as? Cell else {
            fatalError("Unable to dequeue \(String(describing: Cell.self))")
        }
        let item = items[indexPath.item]
        configureCell?(cell, item)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.item]
        cellSelected?(selectedItem)
    }
}
