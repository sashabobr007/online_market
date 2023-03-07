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


//    func handleLogin(username : String, password: String) {
//        print("3")
//
//    }
    //LinearGradient(colors: [.green, .green, .white], startPoint: .leading, endPoint: .trailing)

    var body: some View {
        VStack{
            VStack{
                
                Text("E - MarKet").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100).background(.green).font(.title).foregroundColor(.white).fontWeight(.bold)
               // Color(.systemGreen).ignoresSafeArea().frame(height: 50)
             

            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .topLeading)
            
            VStack{
                
                
                TextField(
                    "Login",
                    text: $login)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .border(Color(UIColor.separator)).padding().textFieldStyle(.roundedBorder)
                
                SecureField(
                    "Password",
                    text: $password
                ) {
                    //handleLogin(username: login, password: password)
                }
                .border(Color(UIColor.separator)).textFieldStyle(.roundedBorder).padding()
                
             
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            
            
            VStack{
                
                Button{
                    print("3")

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
