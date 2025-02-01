//
//  FileManagerUsecase.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import UIKit

protocol FileManagerUseCaseProtocol {
    func saveImage(image: UIImage, imageName: String, folderName: String)
    func getImage(imageName: String, folderName: String) -> UIImage?
    func fetchOrDownloadImage(from urlString: String?, imageName: String, folderName: String) async -> UIImage?
}

struct FileManagerUsecase: FileManagerUseCaseProtocol {
    private let repo: FileManagerRepositoryProtocol
    
    init(repo: FileManagerRepositoryProtocol = FileManagerRepository()) {
        self.repo = repo
    }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        repo.saveImage(image: image, imageName: imageName, folderName: folderName)
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        repo.getImage(imageName: imageName, folderName: folderName)
    }
    func fetchOrDownloadImage(from urlString: String?, imageName: String, folderName: String) async -> UIImage? {
        await repo.fetchOrDownloadImage(from: urlString, imageName: imageName, folderName: folderName)
    }
}
