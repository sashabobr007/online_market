//
//  Profile.swift
//  WEB
//
//  Created by Александр Алексеев on 08.03.2023.
//

import SwiftUI

struct Profile: View {
    
    //private var bgColors: [Color] = [ .indigo, .yellow, .green, .orange, .brown ]
    private var url = URL(string: Api.url + "getimage/?login=\(LoginUser.login)")
    
    @State private var date: String = "nil"
    
    var body: some View {
        
        VStack(){
            
            Text("Профиль").font(.largeTitle).fontWeight(.bold).frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 20)
            
            VStack{
                
                if LoginUser.login != "Admin"{
                    
                AsyncImage(url: url, content: {
                    image in
                    image.resizable().scaledToFit().clipShape(Circle())
                }, placeholder: {
                    Color.gray
                }).frame(width: 400, height: 400)
            }
                
                Text(LoginUser.login).padding(.top, 40)
                
                Text(date).padding(.top, 40)

                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top).padding(.top, 20)
            
                .task {
                    
                    Api.shared.date(decodedValue: {(value : UserDate) in
                        date = value.date
                    })
                }
            
//            NavigationStack {
//                Image(systemName: "fish.fill").resizable().foregroundColor(.blue).frame(width: 200, height: 200)
//                Spacer(minLength: 10)
//                Text("Name")
//                Spacer(minLength: 10)
////                List(bgColors, id: \.self) { bgColor in
////                    NavigationLink {
////                        Cart()
////                    } label: {
////                        Text(bgColor.description)
////                    }
////
////                }
// //               .listStyle(.plain)
//
//                .navigationTitle("Профиль")
//
//
//            }
//
            
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
    }
}
