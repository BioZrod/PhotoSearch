//
//  FlickrPhotosResponse.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/17/23.
//

import Foundation

struct FlickrSearchResponse: Decodable {
    let photos: FlickrPhotos
}

struct FlickrPhotos: Decodable {
    /*let page: Int
    let pages: Int
    let perpage: Int
    let total: String*/
    let photo: [FlickrPhoto]
}

struct FlickrPhoto: Decodable, Identifiable, Hashable {
    
    let id : UUID = UUID()
    let flickrId: String
    let owner: String
    let secret: String
    let server: String
    let farm: Int
    let title: String
    let ownerName: String
    let dateTaken: String
    
    enum CodingKeys : String, CodingKey {
        case flickrId = "id"
        case owner
        case secret
        case server
        case farm
        case title
        case ownerName = "ownername"
        case dateTaken = "datetaken"
    }
    
    func getImageURL(size: String?) -> URL?{
        
        guard let imageSize = size else {
            return URL(string: "https://live.staticflickr.com/\(server)/\(flickrId)_\(secret).jpg")
        }
        
        return URL(string: "https://live.staticflickr.com/\(server)/\(flickrId)_\(secret)_\(imageSize).jpg")
    }
    
    func getFormattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateTaken) ?? Date()

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM d yyyy"
        return outputFormatter.string(from: date)
    }
}
