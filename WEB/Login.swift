//
//  Test.swift
//  WEB
//
//  Created by Александр Алексеев on 04.03.2023.
//

import SwiftUI

struct Login: View {
    @State private var login: String = ""
    @State private var password: String = ""

    //LinearGradient(colors: [.green, .green, .white], startPoint: .leading, endPoint: .trailing)

    var body: some View {
        VStack{
            VStack{
                
                Text("E - MarKet").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100).background(.green).font(.title).foregroundColor(.white).fontWeight(.bold)
             

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
                
             
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            
            
            VStack{
                
                Button{
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarView())

                }label: {
                    Text("login").padding().font(.title).foregroundColor(.white).frame(maxWidth: .infinity)
                }.background(Color(cgColor: UIColor.systemGreen.cgColor)).clipShape(Capsule()).padding(.all).frame(width: 380, height: 40, alignment: .leading)
                Button{
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SignIn())
                }label: {
                    Text("Не зарегестрировались? Жмите!")
                }.padding()
            }
           
        }.background(.white)
       
      
        
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
