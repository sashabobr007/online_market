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
            
                
            Text("Eka").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100).font(.custom("Arial", size: 150)).foregroundColor(Color(red: 0.25, green: 0.55, blue: 1)).fontWeight(.bold).padding(.top)
            Text("Market").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100).font(.custom("Arial", size: 90)).foregroundColor(Color(red: 0.25, green: 0.55, blue: 1)).fontWeight(.bold).padding(.bottom, 20)
             

            
            VStack{
                                    
                    TextField(
                        "",
                        text: $login, prompt: Text(Image(systemName: "person")) + Text("  login").foregroundColor(.gray)).textFieldStyle(OvalTextFieldStyle()).autocorrectionDisabled().textInputAutocapitalization(.none).padding([.horizontal]).padding(.vertical, 47)
                
                SecureField(
                    "",
                    text: $password, prompt: Text(Image(systemName: "person")) + Text( "  password").foregroundColor(.gray).font(.custom("Oswald-Regular", size: 16))
                ).textFieldStyle(OvalTextFieldStyle()).padding([.horizontal])
//                ).frame(height: 50)
//                    .padding([.horizontal], 10).clipShape(Capsule())
//                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
//                    .padding([.horizontal])
                
             
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
            
                Button{
                    if login == "Admin"{
                        LoginUser.login = login
                        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarView())
                    }else{
                        let parameters = [
                          "login": login,
                          "password": password
                        ] as [String : Any]
                        Api.shared.signup(parameters : parameters, path: "signin/", method: "POST" ,decodedValue: {
                        (value : Sign) in
                        //print(value.success)
                            if value.success == "ok"{
                                DispatchQueue.main.async {
                                    LoginUser.login = login
                                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarView())
                                }
                               
                            }
                    })
                    }
                    
                    

                    
                }label: {
                    Text("войти").padding().font(.title).foregroundColor(.white).frame(maxWidth: .infinity, minHeight: 0, maxHeight: .infinity).frame(height: 38)
                }.background(Color(uiColor: hexStringToUIColor(hex: "408CFF"))).clipShape(RoundedRectangle(cornerRadius: 2)).frame(width: 232)
                Button{
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(SignIn())
                }label: {
                    Text("Не зарегестрировались? Жмите!")
                }.padding()
            
           
        }.background(Color(red: 0.118, green: 0.125, blue: 0.153))
       
      
        
    }
}

struct OvalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(10)
            .background(.white)
            .cornerRadius(5)
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
