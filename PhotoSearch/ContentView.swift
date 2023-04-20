//
//  ContentView.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/16/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tabSelection : Int = 0
    @State private var currentPage : Int = 1
    @StateObject var cardsViewModel = CardsViewModel()
    
    var body: some View {
        
        TabView(selection: $tabSelection) {
            
            FeedView(currentPage: $currentPage)
                .tabItem {
                    Text("Feed")
                }
                .tag(0)
                .environmentObject(cardsViewModel)
            
            SearchView(tabSelection: $tabSelection, currentPage: $currentPage)
                .tabItem {
                    Text("Search")
                }
                .tag(1)
                .environmentObject(cardsViewModel)
        }
        /*.onAppear() {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundColor = UIColor.black
            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]
            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
            UITabBar.appearance().standardAppearance = tabBarAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }*/
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
