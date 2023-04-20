//
//  FeedView.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/16/23.
//

import SwiftUI

struct FeedView: View {
    
    var gridItemLayout = [GridItem(.fixed(600)), GridItem(.fixed(600)), GridItem(.fixed(600))]
    @EnvironmentObject var cardsViewModel : CardsViewModel
    @FocusState private var isPhotoSelected : UUID?
    @Binding var currentPage: Int

    var body: some View {
        
        VStack(alignment: .leading) {
     
            Text(self.cardsViewModel.feedTitle())
                .font(.title3)

            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: gridItemLayout) {
                    ForEach(self.cardsViewModel.photos, id: \.id) { photo in
                        VStack {
                            CardView(title: photo.title, author: photo.owner, publishDate: photo.getFormattedDate(), thumbnail: photo.getImageURL(size: "z")!)
                                .focusable()
                                .focused($isPhotoSelected, equals: photo.id)
                                .background(isPhotoSelected == photo.id ? Color.blue.opacity(0.5) : Color.clear)
                                .border(isPhotoSelected == photo.id ? Color.white : Color.clear, width: 4)
                                .id(photo.id)
                        }
                    }
                }
            }
            .onChange(of: isPhotoSelected) { newValue in
                if let index = cardsViewModel.photos.firstIndex(where: { $0.id == isPhotoSelected }) {
                    
                    let arraySize = cardsViewModel.photos.count
                    
                    if (index == (arraySize - 1) || index == (arraySize - 2) || index == (arraySize - 3) || index == (arraySize - 4) || index == (arraySize - 5)  || index == (arraySize - 6)) {
                        self.currentPage += 1
                        if(self.cardsViewModel.displayTrending) {
                            //TODO: research more about getPopularPhotos API as is returning empty
                            //self.cardsViewModel.getPopularPhotos(page: self.currentPage)
                            self.cardsViewModel.getPhotos(searchQuery: "dogs", page: self.currentPage) { success in
                                
                            }
                        } else {
                            self.cardsViewModel.getPhotos(searchQuery: self.cardsViewModel.searchTerm, page: self.currentPage) { success in
                                
                            }
                        }
                    }
                }
            }
            .onAppear {

                if(self.cardsViewModel.displayTrending) {
                    self.cardsViewModel.clearPhotos()
                    //self.cardsViewModel.getPopularPhotos(page: self.currentPage)
                    self.cardsViewModel.getPhotos(searchQuery: "dogs", page: currentPage) { success in
                        
                    }
                }
                
                if(!self.cardsViewModel.tempSearchTerm.isEmpty) {
                    self.cardsViewModel.searchTerm = self.cardsViewModel.tempSearchTerm
                }
            }
        }
        .background(.black)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(currentPage: .constant(1))
    }
}
