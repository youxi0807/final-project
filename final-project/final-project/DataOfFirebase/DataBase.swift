//
//  DataBase.swift
//  final-project
//
//  Created by User03 on 2023/5/29.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Player: Codable, Identifiable {
    @DocumentID var id: String?
    var constellation: String
    var birthday: Date
    var nickName: String
    var gender: String
}

struct PlayerOnce: Codable, Identifiable {
    @DocumentID var id: String?
    let playername: String
    let joinDate: Date
    let email: String
    
}

struct PlayerPhoto:Codable, Identifiable {
    @DocumentID var id: String?
    let photoURL: URL
}

class FirebaseData: ObservableObject {
    
    @Published var player = Player(constellation: "獅子座", birthday: Date(), nickName: "", gender: "男")
    @Published var playerOnce = PlayerOnce(playername: "", joinDate: Date(), email: "")

    
}



//新增(可更動)
func createPlayer(storeData:Player, email:String) {
    let db = Firestore.firestore()
    let player = storeData
    do {
//        let documentReference = try db.collection("players").addDocument(from: player) // 不指定文件id
//        print(documentReference.documentID)
        try db.collection("players").document(email).setData(from: player) // 指定id的寫法
    } catch {
        print(error)
    }
}
//新增(不可更動)
func createPlayerOnce(storeData:PlayerOnce, email:String) {
    let db = Firestore.firestore()
    let PlayerOnce = storeData
    do {
//        let documentReference = try db.collection("players").addDocument(from: player) // 不指定文件id
//        print(documentReference.documentID)
        try db.collection("playersOnce").document(email).setData(from: PlayerOnce) // 指定id的寫法
    } catch {
        print(error)
    }
}

//新增個人圖片的URL
func createPlayerPhotoURL(storeURL:PlayerPhoto, email:String) {
    let db = Firestore.firestore()
    let URL = storeURL
    do{
        try db.collection("playersPhoto").document(email).setData(from: URL)
    }catch{
        print("失敗",error)
    }
}

//載入
func fetchPlayersOnce(email:String,completion: @escaping(Result<PlayerOnce,Error>)->Void){
    let db = Firestore.firestore()
    db.collection("playersOnce").document(email).getDocument { document, error in
        
        guard let document = document,document.exists,let player = try?document.data(as: PlayerOnce.self)else
        {
            if let error = error{
                print("錯誤訊息：",error)
                completion(.failure(error))
            }
            return
        }
       
        completion(.success(player))
    }
    
}


func fetchPlayers(email:String,completion: @escaping(Result<Player,Error>)->Void){
    let db = Firestore.firestore()
    db.collection("players").document(email).getDocument { document, error in
        
        guard let document = document,document.exists,let player = try?document.data(as: Player.self)else
        {
            if let error = error{
                print("錯誤訊息：",error)
                completion(.failure(error))
            }
            return
        }
       
        completion(.success(player))
    }
}

func fetchPlayersPhoto(email:String,completion: @escaping(Result<PlayerPhoto,Error>)->Void){
    let db = Firestore.firestore()
    db.collection("playersPhoto").document(email).getDocument { document, error in
        
        guard let document = document,document.exists,let playerPhoto = try?document.data(as: PlayerPhoto.self)else
        {
            if let error = error{
                print("錯誤訊息：",error)
                completion(.failure(error))
            }
            return
        }
       
        completion(.success(playerPhoto))
    }
}

// Check 狀態
func checkPlayersChange() {
    let db = Firestore.firestore()
    db.collection("players").addSnapshotListener { snapshot, error in
        guard let snapshot = snapshot else { return }
        snapshot.documentChanges.forEach { documentChange in
            switch documentChange.type {
            case .added:
                print("added")
                guard let player = try? documentChange.document.data(as: Player.self) else { break }
                print(player)
            case .modified:
                print("modified")
            case .removed:
                print("removed")
            }
        }
    }
}
//修改
func modifyPlayer(constellation:String, nickName:String, birthday:Date) {
        let db = Firestore.firestore()
        let documentReference =
            db.collection("players").document("玩家資訊")
        documentReference.getDocument { document, error in
                        
          guard let document = document,
                document.exists,
                var player = try? document.data(as: Player.self)
          else {
                    return
          }
            player.constellation = constellation
            player.nickName = nickName
            player.birthday = birthday
          do {
             try documentReference.setData(from: player)
          } catch {
             print(error)
          }
                        
        }
}
//刪除
func deleteData(collection:String, document:String){
    let db = Firestore.firestore()
    let documentReference = db.collection(collection).document(document)
    documentReference.delete()
}
