//
//  Catalog.swift
//  WEB
//
//  Created by Александр Алексеев on 08.03.2023.
//

import SwiftUI

struct Cart: View {
    @State var Tovars = TovarsCart
    @State var showsAlert = false
    @State  var height = false

    var sum : Int {
        var s = 0
        Tovars.forEach({tovar in
            s += tovar.price
        })
        return s
    }
    var body: some View {
       
        
        VStack{
            ScrollView(.vertical){
                
                LazyVGrid(columns: Array (repeating: GridItem(.flexible(), spacing: 10), count: 2), spacing: 20)
                {
                    ForEach(Tovars) { tovar in
                        Product(tovar: tovar)
                        
                    }.padding(5)
                    
                }
            }.frame(maxWidth : .infinity).refreshable {
                self.Tovars = TovarsCart
            }.task {
                self.Tovars = TovarsCart
                
            }
            
            VStack{
                HStack{
                    Text("Итого : ").font(.largeTitle).fontWeight(.heavy)
                    Spacer()
                    Text(String(sum) + " ₽").font(.largeTitle).fontWeight(.heavy)
                }.padding()
                Button{
                    TovarsCart.removeAll()
                    self.Tovars = TovarsCart
                }label: {
                    Text("Очистить корзину").padding().font(.title).foregroundColor(.white).frame(width: 380, height: 60)
                }.background(Color(.systemRed)).clipShape(Capsule()).cornerRadius(15).padding(.top)
                Button{
                    showsAlert.toggle()
                    TovarsCart.removeAll()
                    self.Tovars = TovarsCart
                } label: {
                   
                    Text("Купить").padding().font(.title).foregroundColor(.white).frame(width: 380, height: 60)
                }.background(Color(.systemGreen)).clipShape(Capsule()).cornerRadius(15).padding(.top).alert("Поздравляем !!!", isPresented: $showsAlert) {
                    
                }
                
            }.frame(minWidth: 0, maxWidth: .infinity,minHeight: 0, alignment: .bottom)
        }
        
    }
}

struct Catalog_Previews: PreviewProvider {
    static var previews: some View {
        Cart()
    }
}
