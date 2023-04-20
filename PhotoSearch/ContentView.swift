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
        .onAppear {
            let standardAppearance = UITabBarAppearance()
            standardAppearance.backgroundColor = UIColor(Color.black)
            standardAppearance.selectionIndicatorTintColor = UIColor(Color.white)
            UITabBar.appearance().standardAppearance = standardAppearance
            UITabBar.appearance().scrollEdgeAppearance = standardAppearance
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
