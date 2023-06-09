//
//  GameWaitView.swift
//  final-project
//
//  Created by User03 on 2023/5/31.
//

import SwiftUI
import Kingfisher

struct GameWaitView: View {
    @Binding var currentpage : pages
    @Binding var email :String
    @Binding var inviteNumber:String
    
    @State var playername = "白謹瑜"
    @State var isReadyWord = "準備"
    @State var readyColor = Color.secondary
    @State var showChangeRole = false
    @State var couldStartGameBtndisable = true
    @State var money = ""
   
    let exitNotificaiton = NotificationCenter.default.publisher(for: Notification.Name("Player exit"))
    let startNotificaiton = NotificationCenter.default.publisher(for: Notification.Name("game start"))

    @EnvironmentObject var firebaseOfRoomdata : FirebaseDataOfRoom
    @ObservedObject var firebaseData : FirebaseData
    var body: some View {
        VStack{
            ZStack{
                
                HStack{
                    
                    Button(action: {
                        firebaseOfRoomdata.deleteplayer(roomID: inviteNumber, email: email)
                        NotificationCenter.default.post(name: NSNotification.Name("Player exit"), object: nil)
                        //第二次加入房間 因為矩陣沒清掉 髓以會多很多個 之後再想怎辦 (直接清掉會造成 Index Out Of range !)
                    }, label: {
                        Image(systemName: "arrowshape.turn.up.backward.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.yellow)
                        
                        
                    })
                    .frame(width: 30, height: 30, alignment: .center)
                    Spacer()
                    Text("邀請碼：\(inviteNumber)")
                        .foregroundColor(Color.yellow)
                }
                .padding(10.0)
                .background(
                    Color.black
                    
                )
                HStack{
                    Spacer()
                    Text("等待室")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(.yellow)
                    Spacer()
                }
            }
            
            HStack{
                
                Spacer()
                ForEach(0..<4){ index in
                    PlayrtView(index: index).environmentObject(firebaseOfRoomdata)
                }
                Spacer()
                
            }
            Spacer()
            Button(action: {
                if firebaseOfRoomdata.playerself.isHost{
                    firebaseOfRoomdata.changeIsReady(roomID: inviteNumber, email: email)
                    firebaseOfRoomdata.changeGameToStart(roomID: inviteNumber)
                }else{
                    firebaseOfRoomdata.playerself.isready.toggle()
                    firebaseOfRoomdata.changeIsReady(roomID: inviteNumber, email: email)
                }
            }, label: {
                RoundedRectangle(cornerRadius: 5)
                    .foregroundColor(.black)
                    .overlay(
                        Text(firebaseOfRoomdata.playerself.isHost ? "開 始 遊 戲" : firebaseOfRoomdata.playerself.isready ? "取消準備" : "準    備")
                            .foregroundColor(.yellow)
                            .font(.title)
                            
                    )
                    
            })
            .frame(width: 250, height: 40)
            .disabled(firebaseOfRoomdata.playerself.isHost ? couldStartGameBtndisable : false)
            Spacer()
        }
        .background(
            Image("monopoly")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .onReceive(exitNotificaiton, perform: { _ in
                   print("Host Exit")

            currentpage = pages.PlayerWaitView
//                   AVPlayer.waitQueuePlayer.removeAllItems()
//                   AVPlayer.setupLobbyMusic()
//                   AVPlayer.lobbyQueuePlayer.volume = Float(0.5)
//                   AVPlayer.lobbyQueuePlayer.play()
                   
               })
               .onReceive(startNotificaiton, perform: { _ in
                   print("Start")
                
                let gamePlayer = GamePlayer(rolePosition: 0, goAhead: 0, isChangeToYou: firebaseOfRoomdata.playerself.isHost ? true : false, money: Int(money)!, house: "0", playerIndex: firebaseOfRoomdata.playerself.playerIndex)
                var gameMapInformation = GameMapInformation( mapIndex: 0, showBuy: false, whoBuyIndex: 0, whoBuyName: "non", houseLevel: 0)
                var gameMapInformationMatrix = [GameMapInformation]()
                for i in 0..<16{
                    gameMapInformation.mapIndex = i
                    gameMapInformationMatrix.append(gameMapInformation)
                }
                
                createGameMap(roomNumber: inviteNumber, mapItemNumbrt: 16, gameMapInmformation: gameMapInformationMatrix)
                createGamePlayer(roomNumber: inviteNumber, email: email, gamePlayer: gamePlayer)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                 currentpage = pages.GameView
//                       AVPlayer.waitQueuePlayer.removeAllItems()
//                       AVPlayer.setupGameMusic()
//                       AVPlayer.gameQueuePlayer.volume = Float(0.5)
//                       AVPlayer.gameQueuePlayer.play()
                }
               })
        .onAppear(){
            fetchplayerInformation(roomID: inviteNumber, email: email) { result in
                switch result{
                case .success(let playerInformation):
                    firebaseOfRoomdata.playerself = playerInformation
                case .failure(_):
                    break
                }
            }
            firebaseOfRoomdata.checkRoomsChange(roomID: inviteNumber){ result in
                switch result{
                case .success(let changeType):
                    if changeType == "removed"{
                        if firebaseOfRoomdata.player.isEmpty{
                            firebaseOfRoomdata.deleteroom(roomID: inviteNumber)
                        }
                    }else if changeType == "modified"{
                        var temp = false
                        for i in firebaseOfRoomdata.player.indices {
                            if !firebaseOfRoomdata.player[i].isready {
                                temp = true
                            }
                        }
                        couldStartGameBtndisable = temp
                    }else if changeType == "added"{
                        
                    }
                case .failure(_):
                    break
                }
            }
            firebaseOfRoomdata.checkGameStart(roomID: inviteNumber) { result in
                switch result{
                case .success(let roomCheck):
                    if roomCheck.isGameStart{
                        money = String(roomCheck.money)
                        print("成功")
                        NotificationCenter.default.post(name: NSNotification.Name("game start"), object: nil)
                    }
                    print("失敗")
                case .failure(_):
                    break
                }
            }
            
            
        }
            
            
        
    }
}

struct GameWaitView_Previews: PreviewProvider {
    static var previews: some View {
        GameWaitView(currentpage: .constant(pages.GameWaitView), email: .constant(""), inviteNumber: .constant(""), firebaseData: FirebaseData())
            .previewLayout(.fixed(width: 651, height: 297))
            .environmentObject(FirebaseDataOfRoom())
            .environmentObject(FirebaseData())
           
    }
}

 

struct PlayrtView: View {
    @State var showChangeRole = false
    @State var uiImage = ""
    @State var nickName = ""

    @EnvironmentObject var firebaseOfRoomdata : FirebaseDataOfRoom
    var index: Int = 0
    var body: some View {
        VStack{
            HStack{
                if index < firebaseOfRoomdata.playerphoto.count && index < firebaseOfRoomdata.player.count{
                    Spacer()
                    KFImage(URL(string: firebaseOfRoomdata.player[index].photoURL))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text(firebaseOfRoomdata.player[index].personalnickName)
                        .foregroundColor(Color.black)
                    Spacer()
                   
                }else{
                    Spacer()
                       Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text("等待加入")
                    Spacer()
                        
                }
                   
                
            }
            .frame(width: 150)
            .background(Color.purple)
            if index < firebaseOfRoomdata.player.count{
                RoleView(showChangeRole: $showChangeRole, roleChose: $firebaseOfRoomdata.player[index].personalChoseRole, playerIndex: $firebaseOfRoomdata.player[index].playerIndex)
            }
            
            if index < firebaseOfRoomdata.player.count{
                Text(firebaseOfRoomdata.player[index].isHost ? "室長": "準備")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .opacity(0.8)
                    .frame(width: 150)
                    .background(
                        Capsule()
                            .foregroundColor(firebaseOfRoomdata.player[index].isready ? .black : .gray)
                    )
            }else{
                
                Text("準備")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .opacity(0.8)
                    .frame(width: 150)
                    .background(
                        Capsule()
                            .foregroundColor(Color.gray)
                    )
            }
            
        }
        .frame(width: 160)
        
            
        
        
    }
}

struct RoleView: View {
    @Binding var showChangeRole:Bool
    @Binding var roleChose: Int
    @Binding var playerIndex: Int
    var body: some View {
        VStack{
            
            HStack{
                Spacer()
                if showChangeRole{
                    Button(action: {
                        if roleChose != 0{
                            roleChose = roleChose - 1
                        }
                    }) {
                        Image(systemName: "arrow.left.square.fill")
                            .background(Color.secondary)
                    }
                    .foregroundColor(.white)
                }
                Spacer()
                Text(Role[roleChose])
                Spacer()
                if showChangeRole{
                    Button(action: {
                        if roleChose != Role.count - 1{
                            roleChose = roleChose + 1
                        }
                    }) {
                        Image(systemName: "arrow.right.square.fill")
                            .background(Color.secondary)
                    }
                    .foregroundColor(.white)
                }
                Spacer()
            }
            .background(playerColor[playerIndex + 1])
            Image(Role[roleChose])
                .resizable()
                .scaledToFit()
                .frame(width: 120,height: 130, alignment: .center)
                .background(
                    Circle()
                        .foregroundColor(.white)
                )
            
            
            
            
        }
        .frame(width: 150)
        .background(
            Rectangle()
                .foregroundColor(.black)
                .opacity(0.9)
        )
    }
}
