//
//  PageController.swift
//  final-project
//
//  Created by User03 on 2023/5/29.
//

import SwiftUI
import FirebaseAuth

enum pages{
    case LoginView, PlayerWaitView, RegisterView, CreateRoleView, GameWaitView, GameView
}
/*struct PageController: View {
    @State var currentPage = pages.LoginView
    @State var email = ""
    @State var name = ""
    @State var date = Date()
    @State var showEditorView = true
    @State var image : UIImage?
    @State var inviteNumber = ""
    @State var nickName1 = "等待加入"
    @State var nickName2 = "等待加入"
    @State var nickName3 = "等待加入"
    @State var nickName4 = "等待加入"
    @State var uiImage1 = ""
    @State var uiImage2 = ""
    @State var uiImage3 = ""
    @State var uiImage4 = ""
    @StateObject var firebaseData = FirebaseData()
    @StateObject var firebaseOfRoomdata = FirebaseDataOfRoom()
    var body: some View {
        ZStack{
            switch currentPage
            {
            case pages.LoginView: LoginView(playerAccount: $currentPage, name: $email, date: $name, currentPage: $date, showEditorView: $showEditorView, image: $image, showregisterView: firebaseData)
            case pages.PlayerWaitView: PlayerWaitView(firebaseData: firebaseData, currentPage: $currentPage, email: $email, playerName: $name, date: $date, showEditorView: $showEditorView, image: $image, roomNumber: $inviteNumber )
              
            case pages.RegisterView: RegisterView(currentpage: $currentPage, showEditorView: $showEditorView, playerName: $name, playerAccountRegister: $email, showRegisterView: .constant(false))
            case pages.CreateRoleView: CreateRoleView(currentpage: $currentPage, uiImage: $image, email: $email)
           
            case pages.GameWaitView: GameWaitView( currentpage: $currentPage, email: $email, inviteNumber: $inviteNumber, firebaseData:  firebaseData).environmentObject(firebaseOfRoomdata)
            case pages.GameView: GameView().environmentObject(firebaseOfRoomdata)
                
            }
        }
       
        
    }
}

struct PageController_Previews: PreviewProvider {
    static var previews: some View {
        PageController( image: UIImage(systemName: "photo")!)
            .previewLayout(.fixed(width: 651, height: 297))
    }
}*/
