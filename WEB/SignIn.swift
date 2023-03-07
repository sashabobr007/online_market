//
//  SignIn.swift
//  WEB
//
//  Created by Александр Алексеев on 07.03.2023.
//

import SwiftUI


struct SignIn: View {
    
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var date = Date()
    
    var body: some View {
        
        VStack{
            VStack{
                
                Text("Registration").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100).background(.green).font(.title).foregroundColor(.white).fontWeight(.bold)
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
                
                DatePicker(
                        "Дата рождения",
                        selection: $date,
                        displayedComponents: [.date]
                ).padding().foregroundColor(.blue)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            
            
            VStack{
                
                Button{
                    print(date.description)
//(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SignIn())
                }label: {
                    Text("Sign In").padding().font(.title).foregroundColor(.white).frame(maxWidth: .infinity)
                }.background(Color(cgColor: UIColor.systemGreen.cgColor)).clipShape(Capsule()).padding(.all).frame(width: 380, height: 40, alignment: .leading).padding(.bottom)
               
            }
           
        }.background(.white)
        
        
        
        
       
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
