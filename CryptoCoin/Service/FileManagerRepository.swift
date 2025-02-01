//
//  FileManagerRepository.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 01.02.25.
//

import UIKit


protocol FileManagerRepositoryProtocol {
    func saveImage(image: UIImage, imageName: String, folderName: String)
    func getImage(imageName: String, folderName: String) -> UIImage?
    func fetchOrDownloadImage(from urlString: String?, imageName: String, folderName: String) async -> UIImage?
}

struct FileManagerRepository: FileManagerRepositoryProtocol {

    let fileManager: LocalFileManagerProtocol
    
    init(fileManager: LocalFileManagerProtocol = LocalFileManager.instance) {
        self.fileManager = fileManager
    }
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        fileManager.saveImage(image: image, imageName: imageName, folderName: folderName)
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        fileManager.getImage(imageName: imageName, folderName: imageName)
    }
    
    func fetchOrDownloadImage(from urlString: String?, imageName: String, folderName: String) async -> UIImage? {
        await fileManager.fetchOrDownloadImage(from: urlString, imageName: imageName, folderName: folderName)
    }
}
