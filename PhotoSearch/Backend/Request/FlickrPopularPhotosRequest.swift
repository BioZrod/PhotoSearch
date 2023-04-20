//
//  FlickrPopularPhotosRequest.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/17/23.
//

struct FlickrPopularPhotosRequest {
    
    let apiKey : String
    let page : Int

    func buildRequest() -> [String : Any] {
       return  [
        "method": "flickr.photos.getPopular",
        "api_key": apiKey,
        "sort": "interestingness-desc",
        "date": "today",
        "extras": "owner_name,date_taken",
        "nojsoncallback":  "1",
        "format": "json",
        "pages" : page,
        "per_page" : 15,
       ]
    }
}
