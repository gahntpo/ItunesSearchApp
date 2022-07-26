//
//  MovieSectionView.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 26.07.22.
//

import SwiftUI

struct MovieSectionView: View {
    
    let movies: [Movie]
    
    var body: some View {
        
        ScrollView(.horizontal) {
            LazyHStack(alignment: .top, spacing: 0) {
                ForEach(movies) { movie in
                    
                    VStack(alignment: .leading) {
                        
                        ImageLoadingView(urlString: movie.artworkUrl100, size: 100)
                        
                        Text(movie.trackName)
                        Text(movie.primaryGenreName)
                            .foregroundColor(Color.gray)
                    }
                    .lineLimit(2)
                    .frame(width: 80)
                    .font(.caption)
                }
            }
            .padding([.horizontal, .bottom])
            
        }
    }
}

struct MovieSectionView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSectionView(movies: [Movie.example()])
    }
}
