//
//  TovarDetailView.swift
//  WEB
//
//  Created by Александр Алексеев on 03.04.2023.
//

import SwiftUI

struct TovarDetailView: View {
    @Binding var selectedTovar : Tovar!
    @Binding var isShow : Bool
    var body: some View {
        VStack{
            VStack (alignment: .leading){
                Button (action: {
                    withAnimation (.easeOut){isShow.toggle()}
                }) {
                    Image (systemName: "chevron.left").font(.title).foregroundColor(.green)
                }
                
                
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading).padding(.leading)
            VStack{
                AsyncImage(url: URL(string: Api.url + "getimage_product/?id=\(String(selectedTovar.idimage))"), content: {
                    image in
                    image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 15)).rotationEffect(.degrees(90), anchor: .center)
                }, placeholder: {
                    Color.gray
                }).frame(width: 350, height: 350)
               // Image(systemName: "fish").resizable().scaledToFit().frame(width: 350, height: 350).foregroundColor(.blue).cornerRadius(15)
                Text(selectedTovar.name).fontWeight(.heavy).font(.title)
                Text(String(selectedTovar.price) + " ₽").font(.largeTitle).padding( 10).fontWeight(.heavy).fontDesign(.serif).font(.title2).background(
                    LinearGradient(gradient: Gradient(colors: [.white, .white, .green]), startPoint: .top, endPoint: .bottom)
                ).clipShape(Capsule())
            }
            VStack(alignment: .leading){
                Text("Описание").font(.headline).fontWeight(.light)
                Text(selectedTovar.description).font(.subheadline).fontWeight(.semibold).multilineTextAlignment(.leading).padding()
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading).padding(.leading)
            VStack{
                Button{
                    TovarsCart.append(selectedTovar)

                }label: {
                    Text("В корзину").padding().font(.title).foregroundColor(.white).frame(width: 380, height: 60)
                }.background(Color(.systemGreen)).clipShape(Capsule()).cornerRadius(15).padding(.top)
            }.frame(minWidth: 0, maxWidth: .infinity,minHeight: 0, maxHeight: .infinity, alignment: .bottom).padding(.bottom, 5)
        
            //Spacer(minLength: 0)
        }
    }
}

//struct TovarDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        TovarDetailView()
//    }
//}
