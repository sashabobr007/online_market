//
//  TabBarView.swift
//  WEB
//
//  Created by Александр Алексеев on 08.03.2023.
//

import SwiftUI

struct TabBarView: View {
    
    @State var selectedTab = "1"
    
    var body: some View {
        TabView (selection: $selectedTab){
            Home().tag("1").tabItem({
                Image(systemName: "house")
                Text("Главная")
            })
            Catalog().tag("2").tabItem({
                Image(systemName: "rectangle.and.text.magnifyingglass")
                Text("Каталог")

            })
            Cart().tag("3").tabItem({
                Image(systemName: "cart")
                Text("Корзина")

            })
            Like().tag("4").tabItem({
                Image(systemName: "heart")
                Text("Избранное")

            })
            Profile().tag("5").tabItem({
                Image(systemName: "person")
                Text("Профиль")

            })
            
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
