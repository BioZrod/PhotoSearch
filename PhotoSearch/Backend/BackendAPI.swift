//
//  BackendAPI.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/17/23.
//

import Foundation
import Alamofire

class BackendAPI {
    
    private var flickrAPIKey: String {
        get {
            guard let fileURL = Bundle.main.url(forResource: "APIKEY", withExtension: "plist"),
                  let plist = NSDictionary(contentsOf: fileURL),
                  let value = plist.object(forKey: "FLICKR_API_KEY") as? String else {
                fatalError("Couldn't load API key from 'APIKEY.plist'.")
            }
            
            if value.starts(with: "_") {
                fatalError("Register for a Flickr API KEY at https://www.flickr.com/services/apps/create/apply/")
            }
            
            return value
        }
    }
    
    func getPopularFlickrPhotos(page : Int, completion: @escaping (Result<[FlickrPhoto], Error>) -> Void) {

        let request = FlickrPopularPhotosRequest(apiKey: flickrAPIKey, page: page)
        
        AF.request("https://www.flickr.com/services/rest/", method: .get, parameters: request.buildRequest(), encoding: URLEncoding.default).validate().responseDecodable(of: FlickrSearchResponse.self) { response in
            
            print(response)
            
            switch response.result {
            case .success(let flickrSearchResponse):
                completion(.success(flickrSearchResponse.photos.photo))

            case .failure(let error):
                if let statusCode = response.response?.statusCode, statusCode != 200 {
                   completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode))))
               } else {
                   completion(.failure(error))
               }
            }
        }
    }

    func getFlickrPhotos(searchQuery : String, page : Int, completion: @escaping (Result<[FlickrPhoto], Error>) -> Void) {
        
        let request = FlickrSearchPhotosRequest(apiKey: flickrAPIKey, searchQuery: searchQuery, page: page)
        
        AF.request("https://www.flickr.com/services/rest/", method: .get, parameters: request.buildRequest(), encoding: URLEncoding.default).validate().responseDecodable(of: FlickrSearchResponse.self) { response in

            switch response.result {
            case .success(let flickrSearchResponse):
                completion(.success(flickrSearchResponse.photos.photo))

            case .failure(let error):
                if let statusCode = response.response?.statusCode, statusCode != 200 {
                   completion(.failure(AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: statusCode))))
               } else {
                   completion(.failure(error))
               }
            }
        }
    }
}
