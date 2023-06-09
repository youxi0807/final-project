//
//  PlayerWaitView.swift
//  final-project
//
//  Created by User03 on 2023/5/31.
//

import SwiftUI
import FirebaseAuth

struct PlayerWaitView: View {
    @ObservedObject var firebaseData : FirebaseData
    @Binding var currentPage : pages
    @Binding var email : String
    @Binding var playerName: String
    @Binding var date : Date
    @State var playerInformations = [PlayerOnce]()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Binding  var showEditorView :Bool
    @State private var gender = "男"
    @State private var constellation = "請選擇星座"
    @State private var birthday = Date()
    @State private var nickname = ""
    @State var showCreategame = false
    @State var isCreater = false
    @State var radius :CGFloat = 0
    @State private var buttondisable = false
    @Binding var image:UIImage?
    @Binding var roomNumber:String

    
    let genders = ["男", "女", "不公開"]
    let constellations = ["不公開","魔羯座", "水瓶座", "雙魚座", "牡羊座", "金牛座", "雙子座", "巨蟹座", "獅子座", "處女座", "天秤座", "天蠍座", "射手座", ]
    var textView: some View {
        WebView()
    }
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Spacer()
                    Text("登入帳號：")
                        .font(.title)
                        .foregroundColor(Color.yellow)
                    Text(email)
                        .font(.title)
                        .foregroundColor(Color.yellow)
                    Button(action: {
                        do {
                            try Auth.auth().signOut()
                            currentPage = pages.LoginView
                        } catch {
                            print(error)
                        }
                    }, label: {
                        Text("登出")
                            .foregroundColor(.white)
                            .font(.title2)
                        
                    })
                    .padding(.horizontal, 10.0)
                    .background(
                        Capsule()
                            .foregroundColor(.red)
                    )
                    .disabled(buttondisable)
                    Spacer()
                }
                .background(Color.black)
                if showEditorView{
                    HStack{
                        VStack{
                            Text("創建角色")
                                .font(.title)
                            
                            Button(action: {
                                
                                currentPage = pages.CreateRoleView
                                
                            }, label: {
                                Image(uiImage: image ?? UIImage(systemName: "photo")! )
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 200, alignment: .center)
                            })
                            
                            HStack{
                                Spacer()
                                Text("姓名：")
                                    .font(.title)
                                Text(playerName)
                                    .font(.title)
                                Spacer()
                            }
                        }
                        
                        VStack{
                            Text("編輯個人資訊")
                                .font(.title)
                                .ignoresSafeArea()
                            VStack(alignment: .leading){
                                
                                HStack{
                                    Text("名稱：")
                                        .font(.title)
                                    TextField("請取名",text: $nickname)
                                        .font(.title)
                                        .background(
                                            Rectangle()
                                                .stroke(lineWidth: 3)
                                                .cornerRadius(10)
                                        )
                                }
                                HStack{
                                    
                                    Text("性別 : ")
                                        .font(.title)
                                    Picker("",selection: $gender) {
                                        ForEach(genders, id: \.self) { (gender) in
                                            Text(gender)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(width: 200)
                                    
                                }
                                HStack{
                                    //                        Spacer()
                                    Text("星座 : ")
                                        .font(.title)
                                    Picker(selection: $constellation,label:Text(constellation).font(.title)) {
                                        ForEach(constellations, id: \.self) { (constellation) in
                                            Text(constellation)
                                        }
                                    }
                                    .clipped()
                                    .shadow(radius: 30)
                                    .pickerStyle(MenuPickerStyle())
                                    .frame(width: 240)
                                    
                                }
                                HStack{
                                    Text("生日 : ")
                                        .font(.title)
                                    DatePicker("", selection: $birthday, displayedComponents: .date)
                                        .font(.title)
                                        .frame(width: 180)
                                }
                                
                            }
                            .padding(.horizontal, 3)
                            .background(
                                Color.white.opacity(0.8).cornerRadius(20)
                            )
                            Button(action: {
                                
                                let player = Player(constellation: constellation, birthday: birthday, nickName: nickname, gender: gender)
                                createPlayer(storeData: player, email: email)
                                showEditorView = false
                                fetchPlayers(email: email){ result in
                                    switch result {
                                        case .success(let player):
                                            firebaseData.player = player
                                            
                                        case .failure(let error):
                                            print(error)
                                        break
                                    }
                                }
                            }, label: {
                                Text("確認")
                                    .font(.title)
                                    .foregroundColor(.white)
                                
                                
                            })
                            .padding(.all, 3)
                            .background(Color.secondary)
                            .cornerRadius(20)
                            
                        }
                        .padding(.bottom, 3.0)
                        .background(
                            Color.white.opacity(0.8).cornerRadius(20)
                        )
                    }
                    
                    
                    
                }else{
                    
                    HStack{
                        VStack{
                           
                            Image(uiImage: image ?? UIImage(systemName: "photo")! )
                                .resizable()
                                .scaledToFit()
                                .frame(width: 250, height: 200, alignment: .center)
                            
                            HStack{
                                Spacer()
                                Text(playerName)
                                    .font(.title)
                                Spacer()
                            }
                        }
                        
                        VStack{
                            HStack{
                                Spacer()
                                Text("個人資訊")
                                    .font(.title)
                                    .foregroundColor(.black)
                                    .offset(x:35)
                                Spacer()
                                Button(action: {
                                    showEditorView = true
                                    fetchPlayers(email: email){ result in
                                        switch result {
                                            case .success(let player):
                                                firebaseData.player = player
                                                let nameTempUse = firebaseData.player.nickName
                                                let genderTempUse = firebaseData.player.gender
                                                let birthdayTempUse = firebaseData.player.birthday
                                                nickname = nameTempUse
                                                gender = genderTempUse
                                                birthday = birthdayTempUse
                                                
                                            case .failure(let error):
                                                print(error)
                                            break
                                        }
                                    }
                                    
                                }, label: {
                                    Image("Editor")
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 20)
                                })
                                .disabled(buttondisable)
                                
                            }
                            .padding(.top, 5.0)
                            VStack(alignment: .leading){
                                
                                HStack{
                                    Text("綽號：")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    Text(firebaseData.player.nickName)
                                        .font(.title)
                                        .foregroundColor(.black)

                                        .multilineTextAlignment(.center)
                                        .frame(width: 200)
                                }
                                HStack{
                                    
                                    Text("性別 : ")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    Text(firebaseData.player.gender)
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 240)
                                    
                                }
                                HStack{
                                    //                        Spacer()
                                    Text("星座 : ")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    Text(firebaseData.player.constellation)
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .clipped()
                                        .shadow(radius: 30)
                                        .frame(width: 240)
                                }
                                
                                HStack{
                                    Text("生日 : ")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    Text(firebaseData.player.birthday, style: .date)
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 230)
                                    
                                    
                                }
                                HStack{
                                    Text("加入時間：")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    Text(date,style: .date)
                                        .font(.title)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.horizontal, 3)
                            .background(
                                Color.white.opacity(0.8).cornerRadius(20)
                            )
                            HStack{
                                Spacer()
                                Button(action: {
                                    buttondisable = true
                                    radius = 3
                                    isCreater = true
                                    showCreategame = true
                                }, label: {
                                    Text("建立遊戲")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                })
                                .disabled(buttondisable)
                                .padding(.all, 5)
                                .background(
                                    Capsule()
                                        .foregroundColor(.red)
                                )
                                Spacer()
                                Button(action: {
                                    buttondisable = true
                                    radius = 3
                                    isCreater = false
                                    showCreategame = true
                                }, label: {
                                    Text("加入遊戲")
                                        .font(.title2)
                                        .foregroundColor(.white)
                                })
                                .padding(.all, 5.0)
                                .background(
                                    Capsule()
                                        .foregroundColor(.purple)
                                )
                                .disabled(buttondisable)
                                Spacer()
                            }
                            .padding(.vertical, 5.0)
                            
                        }
                        .padding(.bottom, 3.0)
                        .background(
                            Color.white.opacity(0.8).cornerRadius(20)
                        )
                    }
                    
                }
                
                
                Spacer()
                
            }
            .alert(isPresented: $showAlert, content: {() -> Alert in
                let answer = alertMessage
                return Alert(title: Text(answer))
            })
            .blur(radius: radius)
            if showCreategame{
                CreateGameView(firebaseData: firebaseData, showCreategame: $showCreategame, currentPage: $currentPage, isCreater: $isCreater, radius: $radius, buttondisable: $buttondisable, roomNumber: $roomNumber)
            }
        }
        .background(
            Image("monopoly")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
       
    }
    
    
    
    
    
    
}

struct PlayerWaitView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerWaitView( firebaseData: FirebaseData(), currentPage: .constant(pages.PlayerWaitView), email: .constant(""), playerName: .constant(""), date: .constant(Date()), showEditorView: .constant(false), image: .constant(UIImage(systemName: "photo")!), roomNumber: .constant(""))
            .previewLayout(.fixed(width: 651, height: 335))
            .environmentObject(FirebaseData())
            .environmentObject(FirebaseDataOfRoom())
        
    }
}
