//
//  CardsViewModel.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/16/23.
//

import Foundation

class CardsViewModel : ObservableObject {
    
    let backendAPI : BackendAPI = BackendAPI()
    
    @Published var photos: [FlickrPhoto] = []
    @Published var tempSearchTerm : String = ""
    @Published var searchTerm : String = ""
    @Published var displayTrending : Bool = true
    
    public func clearPhotos() {
        self.photos.removeAll()
    }
    
    public func getPopularPhotos(page: Int) {
        
        self.backendAPI.getPopularFlickrPhotos(page: page) { result  in
            
            switch result {
                case .success(let photos):
                    self.photos.append(contentsOf: photos)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    public func getPhotos(searchQuery : String, page: Int, completion: @escaping (Bool) -> Void) {
        
        self.backendAPI.getFlickrPhotos(searchQuery: searchQuery, page: page) { result  in
            
            switch result {
                case .success(let photos):
                    self.photos.append(contentsOf: photos)
                    completion(true)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    completion(false)
            }
        }
    }
    
    public func feedTitle() -> String {

        if(self.displayTrending) {
            return "Trending Now On Flickr"
        } else {
            
            if(self.photos.isEmpty) {
                return "No search results for \"\(self.searchTerm)\""
            }
            
            return "Search Results for \"\(self.searchTerm)\""
        }
    }
}
