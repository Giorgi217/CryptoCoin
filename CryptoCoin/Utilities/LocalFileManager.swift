//
//  LocalFileManager.swift
//  CryptoCoin
//
//  Created by Giorgi Amiranashvili on 14.01.25.
//

import Foundation
import SwiftUI

protocol LocalFileManagerProtocol {
    func saveImage(image: UIImage, imageName: String, folderName: String)
    func getImage(imageName: String, folderName: String) -> UIImage?
    func fetchOrDownloadImage(from urlString: String?, imageName: String, folderName: String) async -> UIImage?
}

class LocalFileManager: LocalFileManagerProtocol {
    static let instance = LocalFileManager()
    private init() { }
    
    
    func fetchOrDownloadImage(from urlString: String?, imageName: String, folderName: String) async -> UIImage? {
        guard let imageName = imageName.isEmpty ? nil : imageName else { return nil }
        
        if let cachedImage = getImage(imageName: imageName, folderName: folderName) {
            return cachedImage
        }
        
        guard let urlString = urlString, let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let image = UIImage(data: data) {
                saveImage(image: image, imageName: imageName, folderName: folderName)
                return image
            }
        } catch {
            print("Failed to download image: \(error)")
        }
        return nil
    }
    
    
    func saveImage(image: UIImage, imageName: String, folderName: String) {
        
        createFolderIfNeeded(folderName: folderName)
        
        guard let data = image.pngData(), let url = getURLForImage(imageName: imageName, folderName: folderName)
        else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. ImageName: \(imageName). \(error)")
        }
    }
    
    func getImage(imageName: String, folderName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName, folderName: folderName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded(folderName: String) {
        guard let url = getURLForFolder(folderName: folderName) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let error {
                print("Error creating directory. FolderName: \(folderName). \(error)")
            }
        }
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let folderURL = getURLForFolder(folderName: folderName) else {
            return nil
        }
        return folderURL.appendingPathComponent(imageName + ".png")
    }
}
