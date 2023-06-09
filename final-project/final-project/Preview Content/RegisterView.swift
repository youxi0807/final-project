//
//  RegisterView.swift
//  final-project
//
//  Created by User03 on 2023/5/29.
//


import SwiftUI
import FirebaseAuth

struct RegisterView: View {
    
    @Binding var currentpage : pages
    @Binding var showEditorView: Bool
    @State private var alertMessage = ""
    @State var showAlert = false
    @Binding var playerName :String
    @Binding var playerAccountRegister : String
    @State private var playerPasswordRegister = ""
    @Binding var showRegisterView:Bool
    @State private var showPassword = false
    @State private var showpasswordPic = "eye.slash"
    @State var registerState = false
    
    func register(playerAccountRegister:String, playerPasswordRegister:String) {
        Auth.auth().createUser(withEmail: playerAccountRegister, password: playerPasswordRegister) { result, error in
            
            if let user = result?.user,
               error == nil{
                print(user.email, user.uid)
                
                let playerOnce = PlayerOnce(playername: playerName, joinDate: Date(), email: playerAccountRegister)
                createPlayerOnce(storeData: playerOnce, email: playerAccountRegister)
                alertMessage = "註冊成功"
                registerState = true
                showAlert = true
                
                
            }else {
                print(error?.localizedDescription)
                registerState = false
                showAlert = true
                alertMessage = "註冊失敗，請再試一次"
                return
            }
            return
            
        }
    }
    var body: some View {
        VStack{
            Form{
                Text("註冊資料")
                HStack{
                    Text("姓名")
                    Image(systemName: "person")
                        .foregroundColor(.secondary)
                    TextField("請輸入姓名", text: $playerName)
                }
                HStack{
                    Text("信箱")
                    Image(systemName: "envelope")
                        .foregroundColor(.secondary)
                    TextField("000@email", text: $playerAccountRegister)
                }
                HStack{
                    Text("密碼")
                    Image(systemName: "lock")
                        .foregroundColor(.secondary)
                    if showPassword {
                        TextField("請輸入至少六位數密碼", text: $playerPasswordRegister)
                    } else {
                        SecureField("請輸入至少六位數密碼", text: $playerPasswordRegister)
                    }
                    Image(systemName: showpasswordPic)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            showPassword.toggle()
                            if showPassword {
                                showpasswordPic = "eye"
                            }else{
                                showpasswordPic = "eye.slash"
                            }
                        }
                }
                HStack{
                    Spacer()
                    Text("確定註冊")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            register(playerAccountRegister: playerAccountRegister, playerPasswordRegister: playerPasswordRegister)
                            
                        }
                    Spacer()
                    Text("取消重填")
                        .foregroundColor(.blue)
                        .onTapGesture {
                            playerAccountRegister = ""
                            playerPasswordRegister = ""
                            playerName = ""
                        }
                    Spacer()
                }
            }
            Button(action: {
                showRegisterView = false
            }, label: {
                //Text("已有帳號？按此處登入→")
                Text("返回")
            })
            Spacer()
        }
//        .alert(isPresented: $showAlert, content: {() -> Alert in
//            let answer = alertMessage
//            return Alert(title: Text(answer))
//        })
        .alert(isPresented: $showAlert, content: { Alert(
            title: Text(alertMessage),
            message: Text(""),
            dismissButton: .destructive(Text("確定")) {
                if registerState {
                    
                    
                        showEditorView = true
                    currentpage = pages.PlayerWaitView
                    
                }
            }
        )
        })
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(currentpage: .constant(pages.RegisterView), showEditorView: .constant(true), playerName: .constant(""), playerAccountRegister: .constant(""), showRegisterView: .constant(true))
            .previewLayout(.fixed(width: 651, height: 297))
    }
}
