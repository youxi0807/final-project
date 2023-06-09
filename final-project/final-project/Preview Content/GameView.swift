//
//  GameView.swift
//  final-project
//
//  Created by User03 on 2023/5/31.
//


import SwiftUI



struct GameView: View {
    @State var size = CGSize(width: 70, height: 70)
    @State var rolePosition = 0
    @State var rolePositionBuildType = 0
    @State var nowIndex = 0
    @State var roadText = "赤井宅"
    @State var showBuymessage = false
    @EnvironmentObject var firebaseOfRoomdata : FirebaseDataOfRoom
    @StateObject var firebaseOfGameData = Game()
    @State var showPayInformation = false
    @State var payMoney = 0
    func locationx(forPlayerIndex index: Int) -> CGFloat {
        firebaseOfGameData.map1[firebaseOfGameData.players[index].currentLocation].x
    }
    func locationy(forPlayerIndex index: Int) -> CGFloat {
        firebaseOfGameData.map1[firebaseOfGameData.players[index].currentLocation].y
    }
    private func binding(for map: mapItem) -> Binding<mapItem> {
        guard let mapIndex = firebaseOfGameData.map1.firstIndex(where: { $0.itemName == map.itemName }) else {
                fatalError("Can't find firebaseOfGameData.map1 in array")
            }
            return $firebaseOfGameData.map1[mapIndex]
    }
    var body: some View {
        ZStack{
                /*Image("背景圖")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()*/

            ForEach( Array(firebaseOfGameData.map1.enumerated()),id:\.element.id) { index, item in
                Rectangle()
                    .foregroundColor(firebaseOfGameData.playerColor[item.playerColorIndex])
                    .modifier(IsometricViewModifier())
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .offset(x: item.x, y: item.y)
               
                    
                GameRoadView(size: $size, roadText: binding(for: item).itemName)
                    .offset(x: item.x, y: item.y)
                
            }
            .offset(y: 20)
           
            ForEach( Array(firebaseOfGameData.map1.enumerated()),id:\.element.id) { index, item in
                if item.itemlevel == 1{
                    Image(firebaseOfGameData.hosel1[index].level1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width + 10, height: size.height, alignment: .center)
                    .offset(x: item.x, y: item.y - 10)
                }else if item.itemlevel == 2{
                    Image(firebaseOfGameData.hosel1[index].level2)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .offset(x: item.x, y: item.y - 10)
                }else if item.itemlevel == 3{
                    //階段三
                    Image(firebaseOfGameData.hosel1[index].level3)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width, height: size.height, alignment: .center)
                    .offset(x: item.x, y: item.y - 10)
                }else{
                   
                }
            }
            .offset(y: 20)
           
            if firebaseOfRoomdata.player.count > 0 && firebaseOfGameData.gamePlayers.count > 0{
                
                Image(Role[firebaseOfRoomdata.player[0].personalChoseRole])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35, alignment: .center)
                    .offset(x: locationx(forPlayerIndex: 0), y: locationy(forPlayerIndex: 0)+20)
                VStack{
                    HStack{
                        Image(Role[firebaseOfRoomdata.player[0].personalChoseRole])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 30, alignment: .center)
                        Text(firebaseOfRoomdata.player[0].personalnickName)
                    }
                    .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[0].playerIndex + 1])
                    
                    Text("財產：\(firebaseOfGameData.gamePlayers[0].money)")
                        .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[0].playerIndex + 1])
                }
                .offset(x: -300 ,y: -125)
            }
            if firebaseOfRoomdata.player.count > 1 && firebaseOfGameData.gamePlayers.count > 1{
                Image(Role[firebaseOfRoomdata.player[1].personalChoseRole])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35, alignment: .center)
                    .offset(x: locationx(forPlayerIndex: 1)+roleOffset[1].x, y: locationy(forPlayerIndex: 1)+roleOffset[1].y+20)
                VStack{
                    HStack{
                        Image(Role[firebaseOfRoomdata.player[1].personalChoseRole])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 30, alignment: .center)
                        Text(firebaseOfRoomdata.player[1].personalnickName)
                    }
                    .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[1].playerIndex + 1])
                   
                        Text("財產：\(firebaseOfGameData.gamePlayers[1].money)")
                            .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[1].playerIndex + 1])
                }
                .offset(x: -300 ,y: 125)
            }
            if firebaseOfRoomdata.player.count > 2 && firebaseOfGameData.gamePlayers.count > 2{
                Image(Role[firebaseOfRoomdata.player[2].personalChoseRole])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35, alignment: .center)
                    .offset(x: locationx(forPlayerIndex: 2)+roleOffset[2].x, y: locationy(forPlayerIndex: 2)+roleOffset[2].y+20)
                VStack{
                    HStack{
                        Image(Role[firebaseOfRoomdata.player[2].personalChoseRole])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 30, alignment: .center)
                        Text(firebaseOfRoomdata.player[2].personalnickName)
                    }
                    .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[2].playerIndex + 1])
                    
                    Text("財產：\(firebaseOfGameData.gamePlayers[2].money)")
                        .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[2].playerIndex + 1])
                }
                .offset(x: 300 ,y: -125)
            }
            if firebaseOfRoomdata.player.count > 3 && firebaseOfGameData.gamePlayers.count > 3{
                Image(Role[firebaseOfRoomdata.player[3].personalChoseRole])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35, alignment: .center)
                    .offset(x: locationx(forPlayerIndex: 3)+roleOffset[3].x, y: locationy(forPlayerIndex: 3)+roleOffset[3].y+20)
                VStack{
                    HStack{
                        Image(Role[firebaseOfRoomdata.player[3].personalChoseRole])
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20,height: 30, alignment: .center)
                        Text(firebaseOfRoomdata.player[3].personalnickName)
                    }
                    .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[3].playerIndex + 1])
                    
                    Text("財產：\(firebaseOfGameData.gamePlayers[3].money)")
                        .background(firebaseOfGameData.playerColor[firebaseOfRoomdata.player[3].playerIndex + 1])
                }
                .offset(x: 300 ,y: 125)
            }
           
            
           
            if firebaseOfGameData.gamePlayerSelf.isChangeToYou{
                Button(action: {
                    let goAheadStep = Int.random(in: 1...12)
                    firebaseOfGameData.gamePlayerSelf.isChangeToYou.toggle()
                    firebaseOfGameData.playerGoahead(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail, goahead: goAheadStep) { result in
                        switch result{
                        case .success(let rolePosition):
                            self.rolePosition = rolePosition
                        case.failure(_):
                        break
                        }
                    }
                    

                    //位置未上傳雲端資料庫
                        
                    
                   
                }, label: {
                    Image("骰子")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100, alignment: .center)
                        
                })
                .offset(x: 230, y: 100)
            }
            if showBuymessage {
                Rectangle()
                    .cornerRadius(30)
                    .frame(width: 300, height: 200, alignment: .center)
                    .foregroundColor(.orange)
                    .opacity(0.8)
                    .overlay(
                        VStack{
                            HStack{
                                Spacer()
                                Text("購買項目")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    
                                    .padding(10.0)
                                Spacer()
                                Button(action: {
                                    
                                    showBuymessage = false
                                    rolePositionBuildType = 0
                                    var nextIndex = nowIndex + 1
                                    if nextIndex > firebaseOfRoomdata.player.count - 1{
                                        nextIndex = 0
                                    }
                                    firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                    
                                }, label: {
                                    Image(systemName: "multiply.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                })
                                .frame(width: 30, height: 30, alignment: .center)
                                .offset(x:-20)
                                
                                
                            }
            
                            Text(roadText)
                                .font(.title3)
                                .fontWeight(.bold)
                                .background(Color.white)
                            
                                Spacer()
                            if rolePositionBuildType == 0{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                }
                               
                            }else if rolePositionBuildType == 1{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                    Image(firebaseOfGameData.hosel1[rolePosition].level1)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: size.width, height: size.height, alignment: .center)
                                        .offset(y: -10)
                                }
                            }else if rolePositionBuildType == 2{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                    Image(firebaseOfGameData.hosel1[rolePosition].level2)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: size.width, height: size.height, alignment: .center)
                                    .offset(y: -10)
                                    
                                }
                            }else if rolePositionBuildType == 3{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                    Image(firebaseOfGameData.hosel1[rolePosition].level3)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: size.width, height: size.height, alignment: .center)
                                    .offset(y: -10)
                                    
                                }
                            }
                            HStack{
                                Spacer()
                                Button(action: {
                                    showBuymessage = false
                                    if rolePositionBuildType == 0{
                                        firebaseOfGameData.map[rolePosition].whoBuyIndex = firebaseOfGameData.gamePlayerSelf.playerIndex + 1
                                        firebaseOfGameData.map[rolePosition].whoBuyName = firebaseOfRoomdata.playerself.personalnickName
                                        firebaseOfGameData.map1[rolePosition].playerColorIndex = firebaseOfGameData.gamePlayerSelf.playerIndex + 1
                                        firebaseOfGameData.changeMap(roomID: firebaseOfRoomdata.playerself.roomNumber, rolePosition: rolePosition)
                                        
                                        var selfMoney = firebaseOfGameData.gamePlayerSelf.money
                                        selfMoney = selfMoney - 200
                                        firebaseOfGameData.gamePlayerSelf.money = selfMoney
                                        firebaseOfGameData.PayToPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                                        
                                        var nextIndex = nowIndex + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                    }else if rolePositionBuildType == 1{

                                        var selfMoney = firebaseOfGameData.gamePlayerSelf.money
                                        selfMoney = selfMoney - 500
                                        firebaseOfGameData.gamePlayerSelf.money = selfMoney
                                        firebaseOfGameData.PayToPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                                        
                                        firebaseOfGameData.map[rolePosition].houseLevel = firebaseOfGameData.map[rolePosition].houseLevel + 1
                                        firebaseOfGameData.changeMap(roomID: firebaseOfRoomdata.playerself.roomNumber, rolePosition: rolePosition)
                                        var nextIndex = nowIndex + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                        
                                    }else if rolePositionBuildType == 2{
                                        
                                        var selfMoney = firebaseOfGameData.gamePlayerSelf.money
                                        selfMoney = selfMoney - 1000
                                        firebaseOfGameData.gamePlayerSelf.money = selfMoney
                                        firebaseOfGameData.PayToPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                                        
                                        firebaseOfGameData.map[rolePosition].houseLevel = firebaseOfGameData.map[rolePosition].houseLevel + 1
                                        firebaseOfGameData.changeMap(roomID: firebaseOfRoomdata.playerself.roomNumber, rolePosition: rolePosition)
                                        var nextIndex = nowIndex + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                    }else if rolePositionBuildType == 3{
                                        
                                        var selfMoney = firebaseOfGameData.gamePlayerSelf.money
                                        selfMoney = selfMoney - 2000
                                        firebaseOfGameData.gamePlayerSelf.money = selfMoney
                                        firebaseOfGameData.PayToPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                                        
                                        firebaseOfGameData.map[rolePosition].houseLevel = firebaseOfGameData.map[rolePosition].houseLevel + 1
                                        firebaseOfGameData.changeMap(roomID: firebaseOfRoomdata.playerself.roomNumber, rolePosition: rolePosition)
                                        var nextIndex = nowIndex + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                    }else{
                                        var nextIndex = nowIndex + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                    }
                                    rolePositionBuildType = 0
                                    
                                }, label: {
                                    Text("購買")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .opacity(0.8)
                                })
                                .frame(width: 80)
                                .background(
                                    Capsule()
                                        .foregroundColor(.red)
                                    
                                )
                                Spacer()
                                Button(action: {
                                    showBuymessage = false
                                    rolePositionBuildType = 0
                                    var nextIndex = nowIndex + 1
                                    if nextIndex > firebaseOfRoomdata.player.count - 1{
                                        nextIndex = 0
                                    }
                                    firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                }, label: {
                                    Text("取消")
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                        .opacity(0.8)
                                })
                                .frame(width: 80)
                                .background(
                                    Capsule()
                                        .foregroundColor(.blue)
                                    
                                )
                                Spacer()
                            }
                                
                                
                                Spacer()
                            
                        }
                    )
                        

            }
            if showPayInformation{
                Rectangle()
                    .cornerRadius(30)
                    .frame(width: 300, height: 200, alignment: .center)
                    .foregroundColor(.orange)
                    .opacity(0.8)
                    .overlay(
                        VStack{
                            HStack{
                                Spacer()
                                Text("通知！")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    
                                    .padding(10.0)
                                Spacer()
                        
                            }
                            
                            Text(roadText)
                                .font(.title3)
                                .fontWeight(.bold)
                                .background(Color.white)
                            
                            Spacer()
                            if rolePositionBuildType == 0{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                }
                                
                            }else if rolePositionBuildType == 1{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                    Image(firebaseOfGameData.hosel1[rolePosition].level1)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                        .offset(y: -10)
                                }
                            }else if rolePositionBuildType == 2{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                    Image(firebaseOfGameData.hosel1[rolePosition].level2)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                        .offset(y: -10)
                                    
                                }
                            }else if rolePositionBuildType == 3{
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(firebaseOfGameData.playerColor[firebaseOfGameData.map[rolePosition].whoBuyIndex])
                                        .modifier(IsometricViewModifier())
                                        .frame(width:size.width, height:size.height)
                                    GameRoadView(size: $size, roadText: $roadText)
                                    Image(firebaseOfGameData.hosel1[rolePosition].level3)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: size.width, height: size.height, alignment: .center)
                                        .offset(y: -10)
                                    
                                }
                            }
                            Text("此地方為 \(firebaseOfGameData.map[rolePosition].whoBuyName) 擁有")
                            Text("需付過路費 \(payMoney) $")
                        }
                    )
            }
            
            
           
            
           
        }
        .onDisappear(){
            firebaseOfGameData.deletegameplayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
            firebaseOfRoomdata.deleteplayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
        }
        .onAppear(){
            firebaseOfGameData.fetchselfGameInformation(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail) { result in
                switch result {
                case .success(let gamePlayerself):
                    firebaseOfGameData.gamePlayerSelf = gamePlayerself
                    
                case .failure(let error):
                    print(error)
                }
            }
            firebaseOfGameData.checkGamePlayerChange(roomID: firebaseOfRoomdata.playerself.roomNumber) { changetype,index,moveStep   in
                roadText = firebaseOfGameData.map1[rolePosition].itemName
                nowIndex = index
                if changetype == "Move"{
                    firebaseOfGameData.playerMove(currentPlayerIndex: index, goAhead: moveStep) { message, playerIndex in
                        if nowIndex != firebaseOfRoomdata.playerself.playerIndex{
                            return
                        }
                        if !(rolePosition % 2 == 0){
                            let houseState = firebaseOfGameData.map[rolePosition].whoBuyIndex
                            print(houseState)
                            if houseState == 0 {
                                
                                
                                showBuymessage = true //買房子
                            }else{
                                if houseState - 1 == firebaseOfRoomdata.playerself.playerIndex{
                                    //加蓋
                                    rolePositionBuildType = firebaseOfGameData.map1[rolePosition].itemlevel + 1
                                    if rolePositionBuildType < 4{
                                        showBuymessage = true
                                    }else{
                                        var nextIndex = index + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                        rolePositionBuildType = 0
                                    }
                                    
                                }else{
                                    //付錢
                                    let houseLevel = firebaseOfGameData.map1[rolePosition].itemlevel
                                    rolePositionBuildType = houseLevel
                                    var selfMoney = firebaseOfGameData.gamePlayerSelf.money
                                    if houseLevel == 0{
                                        selfMoney = selfMoney - 500
                                        payMoney = 500
                                    }else if houseLevel == 1{
                                        selfMoney = selfMoney - 1000
                                        payMoney = 1000
                                    }else if houseLevel == 2{
                                        selfMoney = selfMoney - 5000
                                        payMoney = 5000
                                    }else if houseLevel == 3{
                                        selfMoney = selfMoney - 10000
                                        payMoney = 10000
                                    }
                                    let payToplayer = firebaseOfGameData.map[rolePosition].whoBuyIndex - 1
                                    let payPlayerMoney = firebaseOfGameData.gamePlayers[payToplayer].money
                                    firebaseOfGameData.gamePlayerSelf.money = selfMoney
                                    firebaseOfGameData.gamePlayers[payToplayer].money = payPlayerMoney + payMoney
                                    firebaseOfGameData.reciveMoney(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[payToplayer].personalemail, index: payToplayer)
                                    firebaseOfGameData.PayToPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                                    showPayInformation = true
                                    //2秒後
                                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                                        showPayInformation = false
                                        var nextIndex = index + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                        rolePositionBuildType = 0
                                    }
                                    
                                    
                                }
                                
                            }
                        }else if rolePosition == 0{
                            // 加錢錢
                            
                            //                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                            var nextIndex = index + 1
                            if nextIndex > firebaseOfRoomdata.player.count - 1{
                                nextIndex = 0
                            }
                            firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                        }else if rolePosition == 4{
                            //                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                            var nextIndex = index + 1
                            if nextIndex > firebaseOfRoomdata.player.count - 1{
                                nextIndex = 0
                            }
                            firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                        }else if rolePosition == 8{
                            //                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                            var nextIndex = index + 1
                            if nextIndex > firebaseOfRoomdata.player.count - 1{
                                nextIndex = 0
                            }
                            firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                        }else if rolePosition == 12{
                            //                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                            var nextIndex = index + 1
                            if nextIndex > firebaseOfRoomdata.player.count - 1{
                                nextIndex = 0
                            }
                            firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                        }else if rolePosition % 2 == 0{
                            let houseState = firebaseOfGameData.map[rolePosition].whoBuyIndex
                            if houseState == 0 {
                                
                                
                                showBuymessage = true //買房子
                            }else{
                                if houseState - 1 == firebaseOfRoomdata.playerself.playerIndex{
                                    //加蓋
                                    rolePositionBuildType = firebaseOfGameData.map1[rolePosition].itemlevel + 1
                                    if rolePositionBuildType < 4{
                                        showBuymessage = true
                                    }else{
                                        var nextIndex = index + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                        rolePositionBuildType = 0
                                    }
                                }else{
                                    //付錢
                                    let houseLevel = firebaseOfGameData.map1[rolePosition].itemlevel
                                    rolePositionBuildType = houseLevel
                                    
                                    var haveHighhouse = 0
                                    if firebaseOfGameData.map[2].whoBuyIndex == firebaseOfGameData.map[rolePosition].whoBuyIndex {
                                        haveHighhouse = haveHighhouse + 1
                                    }
                                    if firebaseOfGameData.map[6].whoBuyIndex == firebaseOfGameData.map[rolePosition].whoBuyIndex {
                                        haveHighhouse = haveHighhouse + 1
                                    }
                                    if firebaseOfGameData.map[10].whoBuyIndex == firebaseOfGameData.map[rolePosition].whoBuyIndex {
                                        haveHighhouse = haveHighhouse + 1
                                    }
                                    if firebaseOfGameData.map[14].whoBuyIndex == firebaseOfGameData.map[rolePosition].whoBuyIndex {
                                        haveHighhouse = haveHighhouse + 1
                                    }
                                    
                                    var selfMoney = firebaseOfGameData.gamePlayerSelf.money
                                    if houseLevel == 0{
                                        selfMoney = selfMoney - 1000 * haveHighhouse
                                        payMoney = 1000 * haveHighhouse
                                    }else if houseLevel == 1{
                                        selfMoney = selfMoney - 2000 * haveHighhouse
                                        payMoney = 2000 * haveHighhouse
                                    }else if houseLevel == 2{
                                        selfMoney = selfMoney - 5000 * haveHighhouse
                                        payMoney = 5000 * haveHighhouse
                                    }else if houseLevel == 3{
                                        selfMoney = selfMoney - 8000 * haveHighhouse
                                        payMoney = 8000 * haveHighhouse
                                    }
                                    let payToplayer = firebaseOfGameData.map[rolePosition].whoBuyIndex - 1
                                    let payPlayerMoney = firebaseOfGameData.gamePlayers[payToplayer].money
                                    firebaseOfGameData.gamePlayerSelf.money = selfMoney
                                    firebaseOfGameData.gamePlayers[payToplayer].money = payPlayerMoney + payMoney
                                    firebaseOfGameData.reciveMoney(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[payToplayer].personalemail, index: payToplayer)
                                    firebaseOfGameData.PayToPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail)
                                    showPayInformation = true
                                    //2秒後
                                    DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                                        showPayInformation = false
                                        var nextIndex = index + 1
                                        if nextIndex > firebaseOfRoomdata.player.count - 1{
                                            nextIndex = 0
                                        }
                                        firebaseOfGameData.changToNextPlayer(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.player[nextIndex].personalemail)
                                        rolePositionBuildType = 0
                                    }
                                }
                                
                            }
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                }
                
            }
            firebaseOfGameData.checkPlayerSelfChange(roomID: firebaseOfRoomdata.playerself.roomNumber, email: firebaseOfRoomdata.playerself.personalemail) { result in
                switch result{
                case .success(let gamePlayer):
                    firebaseOfGameData.gamePlayerSelf = gamePlayer
                case .failure(_):
                    break
                    
                }
            }
            firebaseOfGameData.checkGameMapChange(roomID: firebaseOfRoomdata.playerself.roomNumber) { Result in
                
            }
            
        }
        

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(FirebaseDataOfRoom())
            .previewLayout(.fixed(width: 651, height: 297))
    }
}
