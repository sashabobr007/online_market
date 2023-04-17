//
//  SignIn.swift
//  WEB
//
//  Created by Александр Алексеев on 07.03.2023.
//

import SwiftUI
import UIKit

struct SignIn: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var date = Date()
        
    @State var showAction: Bool = false
    @State var showImagePicker: Bool = false

    @State var uiImage: UIImage? = nil

    var sheet: ActionSheet {
        ActionSheet(
            title: Text("Action"),
            buttons: [
                .default(Text("Change"), action: {
                    self.showAction = false
                    self.showImagePicker = true
                }),
                .cancel(Text("Close"), action: {
                    self.showAction = false
                }),
                .destructive(Text("Remove"), action: {
                    self.showAction = false
                    self.uiImage = nil
                })
            ])

    }
    
    var body: some View {
        
        VStack{
            VStack{
                
                Text("Registration").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100).background(.green).font(.title).foregroundColor(.white).fontWeight(.bold)

            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .topLeading)
            
            VStack{
                
                
                TextField(
                    "",
                    text: $login, prompt: Text("Login").foregroundColor(.gray)).foregroundColor(.black).autocorrectionDisabled().textInputAutocapitalization(.none)
                .frame(height: 50)
                    .padding([.horizontal], 10)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                    .padding([.horizontal, .vertical])
            
            SecureField(
                "",
                text: $password, prompt: Text("Password").foregroundColor(.gray)
            ).frame(height: 50)
                .padding([.horizontal], 10)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                .padding([.horizontal])
                
                DatePicker(
                    "Дата рождения",
                    selection: $date,
                    displayedComponents: [.date]
                ).padding().foregroundColor(.blue)
                
                HStack{
                    Text("Выберите фото").foregroundColor(.blue)
                    Spacer()
                    //LibraryImage()
                    //imageView
                    VStack {

                        if (uiImage == nil) {
                            Image(systemName: "camera.on.rectangle").resizable().scaledToFit().foregroundColor(.black)
                                .accentColor(.blue).background(.white).frame(width: 50, height: 50)
                                .onTapGesture {
                                    self.showImagePicker = true
                                }
                        } else {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(10)
                                .onTapGesture {
                                    self.showAction = true
                                }
                        }

                    }

                    .sheet(isPresented: $showImagePicker, onDismiss: {
                        self.showImagePicker = false
                    }, content: {
                        ImagePicker(isShown: self.$showImagePicker, uiImage: self.$uiImage)
                    })

                    .actionSheet(isPresented: $showAction) {
                        sheet
                    }
                    
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .topLeading).padding()
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .bottom)
           
            
            VStack{
                
                Button{
                    let dat = uiImage?.jpegData(compressionQuality: 0.1)

                    let formattedDate = date.formatted(date: .numeric, time: .omitted)
                    let parameters = [
                        "login":  login,
                        "password": password,
                        "birtdate": formattedDate
                    ] as [String : Any]
                    Api.shared.signup(parameters : parameters, path: "signup/", method: "POST", decodedValue: {
                    (value : Sign) in
                    //print(value.success)
                        DispatchQueue.main.async {
                            Api.shared.send(imageData: dat ?? Data(), login: login)
                            LoginUser.login = login
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarView())
                        }

                })
                   
                    

                }label: {
                    Text("Sign Up").padding().font(.title).foregroundColor(.white).frame(maxWidth: .infinity)
                }.background(Color(cgColor: UIColor.systemGreen.cgColor)).clipShape(Capsule()).padding(.all).frame(width: 380, height: 40, alignment: .leading).padding(.bottom)
               
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .bottom)
           
        }.background(.white)
        
        
        
        
       
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
