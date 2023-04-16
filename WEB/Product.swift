//
//  Product.swift
//  WEB
//
//  Created by Александр Алексеев on 03.04.2023.
//

import SwiftUI

func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

struct Product: View {

    var tovar : Tovar
    let url = URL(string: Api.url + "getimage_product/?id=")
    
    let first = Color(uiColor: hexStringToUIColor(hex: "FF9F2E"))
    let second = Color(uiColor: hexStringToUIColor(hex: "FF279C"))
    let third = Color(uiColor: hexStringToUIColor(hex: "BE22FF"))
    let TFirst = Color(uiColor: hexStringToUIColor(hex: "BE22FF"))
    let TSecond = Color(uiColor: hexStringToUIColor(hex: "FF279C"))
    let TThird = Color(uiColor: hexStringToUIColor(hex: "FF981F"))



    var body: some View {
        VStack (alignment: .leading, spacing: 10){
          
                AsyncImage(url: URL(string: Api.url + "getimage_product/?id=\(String(tovar.idimage))"), content: {
                    image in
                    image.resizable().scaledToFit().clipShape(RoundedRectangle(cornerRadius: 15)).rotationEffect(.degrees(90), anchor: .center)
                    
                
                }, placeholder: {
                    //Color.gray
                    ProgressView()
            }).frame(width: 180, height: 180, alignment: .leading)
            
            //Image(systemName: "fish").resizable().scaledToFit().frame(width: 150, height: 150).foregroundColor(.blue).cornerRadius(15)
            Text(tovar.name).fontWeight(.medium).font(.title).lineLimit(2).padding(.leading, 20)
            if tovar.name.count < 9{
                Spacer()
            }
            Text(String(tovar.price) + " ₽").padding(.top, 10).fontWeight(.heavy).fontDesign(.serif).font(.title2).background(
                LinearGradient(gradient: Gradient(colors: [.white, .white, .green]), startPoint: .top, endPoint: .bottom)
            ).clipShape(Capsule()).padding(.leading, 20)
            Button{
                TovarsCart.append(tovar)
        
            }label: {
                LinearGradient(gradient: Gradient(colors: [TFirst, TSecond, TThird]), startPoint: .bottom, endPoint: .top).mask(Text("в корзину").padding().font(.title2)).frame(width: 150, height: 40)
            }.background(Color(.black)).overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(LinearGradient(colors: [first, second, third], startPoint: .top, endPoint: .bottom), lineWidth: 10)).cornerRadius(5).padding(.top).padding(.leading, 20)
        }
    }
}

//struct Product_Previews: PreviewProvider {
//    static var previews: some View {
//        Product()
//    }
//}
