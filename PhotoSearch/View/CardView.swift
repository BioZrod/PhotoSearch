//
//  CardView.swift
//  PhotoSearch
//
//  Created by Rodrigo Saravia Arenas on 4/16/23.
//

import SwiftUI

struct CardView: View {
    
    var title : String
    var author : String
    var publishDate : String
    var thumbnail : URL
    
    var body: some View {
        
        NavigationLink(destination: PhotoView(imageURL: thumbnail), label: {

            AsyncImage(url: thumbnail) { image in
                
                ZStack {
                    image
                        .resizable()
                        .overlay(
                            Rectangle()
                                .stroke(Color.gray, lineWidth: 1.5)
                        )
                        /*.overlay(
                            VStack {
                                Spacer()
                                
                                Rectangle()
                                     .fill(Color.black)
                                     .frame(width: 620, height: 25)
                                     .blur(radius: 2)
                                     .offset(x: 0, y: 10)
                            }
                        )*/
                    
                    VStack(alignment: .leading) {
                        Spacer()
                        
                        HStack {
                            Text(title)
                                .font(.body)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                
                            Spacer()
                        }
                        .padding(.bottom, 1)
                       
                        HStack {
                            Text("\(author) / \(publishDate)")
                                .font(.body)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            
                            Spacer()
                        }
                        .padding(.bottom, 10)
                    }
                    .padding(.horizontal, 10)
                }
                
            } placeholder: {
                Image("placeholder")
                    .resizable()
            }
            .frame(width: 600, height: 300)
        })
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "Test Image", author: "Anonymous", publishDate: "Apr 17 2023", thumbnail: URL(string: "https://live.staticflickr.com/7372/12502775644_acfd415fa7_w.jpg")!)
    }
}
