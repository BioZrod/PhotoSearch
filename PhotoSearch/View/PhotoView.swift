//
//  PhotoView.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/26/23.
//

import SwiftUI

struct PhotoView : View {
    
    var imageURL : URL
    
    var body : some View {
        
        VStack {
            
            AsyncImage(url: imageURL, content: { image in
                image
                    .resizable()
                
            }, placeholder: {
               
            })
            
            Spacer()
            
        }

    }
    
}
