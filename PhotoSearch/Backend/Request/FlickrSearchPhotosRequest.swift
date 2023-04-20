//
//  FlickrSearchPhotosRequest.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/17/23.
//

struct FlickrSearchPhotosRequest {
    
    let apiKey : String
    let searchQuery : String
    let page : Int

    func buildRequest() -> [String : Any] {
       return  [
        "method": "flickr.photos.search",
        "api_key": apiKey,
        "text": searchQuery,
        "content_type" : 1,
        "extras": "owner_name,date_taken",
        "nojsoncallback":  "1",
        "format": "json",
        "page" : page,
        "per_page" : 15,
       ]
    }
}
