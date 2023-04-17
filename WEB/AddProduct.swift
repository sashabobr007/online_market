//
//  AddProduct.swift
//  WEB
//
//  Created by Александр Алексеев on 04.04.2023.
//

import SwiftUI

struct AddProduct: View {
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var price: Float = 10000
    @State private var quantity: Float = 1000
    
    @State private var isEditing = false

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
                
                Text("Новый товар").frame(minWidth: 0, maxWidth: .infinity, minHeight: 100).background(.green).font(.title).foregroundColor(.white).fontWeight(.bold)

            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .topLeading)
            
            VStack{
                
                
                TextField(
                    "",
                    text: $name, prompt: Text("Название").foregroundColor(.gray)).foregroundColor(.black).autocorrectionDisabled().textInputAutocapitalization(.none)
                .frame(height: 50)
                    .padding([.horizontal], 10)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                    .padding([.horizontal, .vertical])
                
                TextField(
                    "",
                    text: $description, prompt: Text("Описание").foregroundColor(.gray)).foregroundColor(.black).autocorrectionDisabled().textInputAutocapitalization(.none)
                .frame(height: 50)
                    .padding([.horizontal], 10)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray))
                    .padding([.horizontal, .vertical])
            
                Slider(
                            value: $price,
                            in: 0...100000,
                            onEditingChanged: { editing in
                                isEditing = editing
                            }
                ).padding([.leading, .trailing])
                        Text("Цена - \(Int(price))")
                            .foregroundColor(isEditing ? .red : .blue)
                
                Slider(
                            value: $quantity,
                            in: 0...100000,
                            onEditingChanged: { editing in
                                isEditing = editing
                            }
                ).padding([.leading, .trailing])
                        Text("Количество - \(Int(quantity))")
                            .foregroundColor(isEditing ? .red : .blue)
             
                
                HStack{
                    Text("Выберите фото").foregroundColor(.blue)
                    Spacer()
                   
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

                    
                    let parameters = [
                        "name":  name,
                        "description": description,
                        "price" : Int(price),
                        "quantity" : Int(quantity)
                        
                    ] as [String : Any]
                    Api.shared.signup(parameters : parameters, path: "new_product/", method: "POST", decodedValue: {
                    (value : Sign) in
                    print(value.success)
                        DispatchQueue.main.async {
                            Api.shared.sendProduct(imageData: dat ?? Data(), login: value.success)
                            
                        }

                })
                   
                    

                }label: {
                    Text("Добавить").padding().font(.title).foregroundColor(.white).frame(maxWidth: .infinity)
                }.background(Color(cgColor: UIColor.systemGreen.cgColor)).clipShape(Capsule()).padding(.all).frame(width: 380, height: 40, alignment: .leading).padding(.bottom)
               
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .bottom)
           
        }.background(.white)

    }
}

struct AddProduct_Previews: PreviewProvider {
    static var previews: some View {
        AddProduct()
    }
}
