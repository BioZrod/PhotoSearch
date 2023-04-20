//
//  SearchView.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/16/23.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var cardsViewModel : CardsViewModel
    @Binding var tabSelection : Int
    @Binding var currentPage : Int
    
    var body: some View {
        VStack {
            
            TextField("Search", text: self.$cardsViewModel.searchTerm)
                .onSubmit {
                    self.cardsViewModel.clearPhotos()
                    self.currentPage = 1
                    
                    if(self.cardsViewModel.searchTerm.isEmpty) {
                        self.cardsViewModel.displayTrending = true
                        self.tabSelection = 0
                    } else {
                        self.cardsViewModel.getPhotos(searchQuery: self.cardsViewModel.searchTerm, page: currentPage) { success in
                            self.cardsViewModel.displayTrending = false
                            self.cardsViewModel.tempSearchTerm = self.cardsViewModel.searchTerm
                            self.tabSelection = 0
                        }
                    }
                }
                .onAppear {
                    self.cardsViewModel.tempSearchTerm = self.cardsViewModel.searchTerm
                    self.cardsViewModel.searchTerm = ""
                }
            
            Spacer()
        }
        .background(.black)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(tabSelection: .constant(1), currentPage: .constant(1))
    }
}
