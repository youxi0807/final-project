//
//  CreateRoleView.swift
//  final-project
//
//  Created by User03 on 2023/5/31.
//

import Foundation
import SwiftUI
import WebKit

extension UIView {
    func snapshot() -> UIImage {
        let rect = CGRect(x: -10, y: 230, width: 400, height: 350)
               let renderer = UIGraphicsImageRenderer(bounds: rect)
               return renderer.image{ rendererContect in
                   layer.render(in: rendererContect.cgContext)
               }
    }
}

struct CreateRoleView: View {
    @Binding var currentpage:pages
    @Binding var uiImage: UIImage?
    @Binding var email:String
    @State var uiImage1: UIImage?
    @State private var name = "peter0"
    @State private var showWebView = true
    @State private var rect: CGRect = .zero
    var webView: some View {
        WebView()
    }
    var body: some View {
        VStack {
            
            if showWebView {
                webView
                   
                
            }
            Button("完成") {
                
                uiImage = UIApplication.shared.windows[0].rootViewController?.view!.snapshot()

                uploadPhoto(image: uiImage!) { result in
                    switch result {
                    case .success(let url):
                        setUserPhoto(url: url){result in
                            switch result {
                            case .success(let str):
                                print(str)
                                downloadUserImage(str:"role", url: url){ result in
                                    switch result {
                                    case .success(let image):
                                        uiImage = image
                                        currentpage = pages.PlayerWaitView
                                    case .failure(_):
                                        break
                                    }
                                }
                                let playerPhoto = PlayerPhoto(photoURL: url)
                                createPlayerPhotoURL(storeURL: playerPhoto, email: email)
                            case .failure(_):
                                break
                            }

                        }
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

struct RectSettings: View {
    @Binding var rect: CGRect
    var body: some View {
        GeometryReader { geometry in
            setView(proxy:geometry)
        }
    }
    
    func setView(proxy: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            rect = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}

struct CreateRoleView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoleView(currentpage: .constant(pages.CreateRoleView), uiImage: .constant(UIImage(systemName: "photo")), email: .constant(""))
    }
}
