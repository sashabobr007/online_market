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
                    //print(uiImage?.pngData()?.base64EncodedData(options: .endLineWithLineFeed))
                    self.showAction = false
                    self.uiImage = nil
                })
            ])

    }
    
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
                    //print(login)
                    //print(password)
                    let formattedDate = date.formatted(date: .numeric, time: .omitted)
                    //print(formattedDate)
                    //let imageView = imageView as! LibraryImage
                    //print(uiImage?.pngData()?.base64EncodedData(options: .endLineWithLineFeed))
(UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(TabBarView())
                }label: {
                    Text("Sign In").padding().font(.title).foregroundColor(.white).frame(maxWidth: .infinity)
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
