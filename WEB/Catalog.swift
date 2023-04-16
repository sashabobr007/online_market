//
//  Cart.swift
//  WEB
//
//  Created by Александр Алексеев on 08.03.2023.
//

import SwiftUI



var TovarsCart: [Tovar] = []


struct Tovar : Identifiable {
    let idimage : Int
    let description : String
    let price : Int
    let quantity : Int
    let name: String
    var id: String { name }
}

struct Catalog: View {
    @State  var selectedTovar : Tovar!
    @State  var isShow = false
    @State  var Tovars: [Tovar] = []
    
    
    var body: some View {
        ZStack{
            if selectedTovar != nil && isShow{
                TovarDetailView(selectedTovar: $selectedTovar, isShow: $isShow)
            }else{
                ScrollView(.vertical){
                    
                    LazyVGrid(columns: Array (repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 20)
                    {
                        ForEach(Tovars) { tovar in
                            
                        
                            Product(tovar: tovar).onTapGesture {
                                withAnimation(.easeIn){
                                    selectedTovar = tovar
                                    isShow.toggle()
                                }
                            }
                            
                        }.padding(5)
                        
                    }
                    
                }.frame(maxWidth : .infinity).refreshable {}

                
            }
            
        }.task {
            //print("task")
            self.Tovars.removeAll()
            await Api.shared.products(decodedValue: {
                 (value : products) in
                 for item in value.product{
                     //print(item.name)
                     Tovars.append(Tovar(idimage: item.id, description: item.description, price: item.price, quantity: item.quantity, name: item.name))
                 }
             })
         }
        
    }
}

struct Cart_Previews: PreviewProvider {
    static var previews: some View {
        Catalog()
    }
}
