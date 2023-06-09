//
//  final_projectApp.swift
//  final-project
//
//  Created by User03 on 2023/5/29.
//

import SwiftUI
import Firebase

@main
struct final_projectApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    /*@State private var name = ""
    init() {
        FirebaseApp.configure()
    }*/
    var body: some Scene {
        WindowGroup {
            //PageController()
            /*GameView()
                .environmentObject(FirebaseDataOfRoom())
                .previewLayout(.fixed(width: 651, height: 297))*/
            LoginView(currentPage: .constant(pages.LoginView), playerAccount: .constant(""), name: .constant(""), date: .constant(Date()), showEditorView: .constant(false), image: .constant(UIImage(systemName: "photo")), firebaseData: FirebaseData())
                .previewLayout(.fixed(width: 651, height: 297))
            /*CreateRoleView(currentpage: .constant(pages.CreateRoleView), uiImage: .constant(UIImage(systemName: "photo")), email: .constant(""))*/
            /*CreateGameView(firebaseData: FirebaseData(), showCreategame: .constant(true), currentPage: .constant(pages.PlayerWaitView), isCreater: .constant(true), radius: .constant(0), buttondisable: .constant(false), roomNumber: .constant("") )
                .previewLayout(.fixed(width: 651, height: 297))
                .environmentObject(FirebaseDataOfRoom())*/
            /*PlayerWaitView( firebaseData: FirebaseData(), currentPage: .constant(pages.PlayerWaitView), email: .constant(""), playerName: .constant(""), date: .constant(Date()), showEditorView: .constant(false), image: .constant(UIImage(systemName: "photo")!), roomNumber: .constant(""))
                .previewLayout(.fixed(width: 651, height: 335))
                .environmentObject(FirebaseData())
                .environmentObject(FirebaseDataOfRoom())*/
            /*WebView()*/
            //SignUpPage(playerAccount: $name)
        }
    }
}
