//
//  StorageOfFirebase.swift
//  final-project
//
//  Created by User03 on 2023/5/29.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseAuth

func uploadPhoto(image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        
        let fileReference = Storage.storage().reference().child(UUID().uuidString + ".jpg")
        if let data = image.jpegData(compressionQuality: 0.9) {
            
            fileReference.putData(data, metadata: nil) { result in
                switch result {
                case .success(_):
                    fileReference.downloadURL { result in
                        switch result {
                        case .success(let url):
                            completion(.success(url))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
}

func setUserPhoto(url: URL, completion: @escaping (Result<String, Error>) -> Void) {
    print("setUserPhoto URL: \(url)")
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    changeRequest?.photoURL = url
    changeRequest?.commitChanges(completion: { error in
        guard error == nil else {
            print(error?.localizedDescription)
            completion(.failure(error!))
            return
        }
    })
    completion(.success("setUserPhoto success"))
}


func downloadUserImage(str:String, url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
    if url == URL(string: "https://www.google.com.tw/?client=safari&channel=iphone_bm")! {
        completion(.success(UIImage(systemName: "person")!))
    }
    if let user = Auth.auth().currentUser {
        // Create a reference to the file you want to download
        let httpsReference = Storage.storage().reference(forURL:url.absoluteString)
        print("downloadUserProfileImg(\(str): \(httpsReference)")
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        httpsReference.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                // Uh-oh, an error occurred!
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                completion(.success(image ?? UIImage(systemName: "person")!))
            }
        }
    }
}
