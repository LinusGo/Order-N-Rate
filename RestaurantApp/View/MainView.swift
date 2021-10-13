//
//  MainView.swift
//  RestaurantApp
//
//  Created by Linus Wang on 4/30/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            RatingView()
                .tabItem {
                    Label("Rating",systemImage:
                        "star.square.fill")
                }
            
//            ContentView()
//                .tabItem {
//                    Label("Menu", systemImage:"list.dash")
//                }

            OrderView()
                .tabItem {
                    Label("Cart",systemImage:
                        "cart")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
    }
}
