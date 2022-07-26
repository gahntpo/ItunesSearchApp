//
//  SearchAllListView.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 26.07.22.
//

import SwiftUI

struct SearchAllListView: View {
    
    @ObservedObject var albumListViewModel: AlbumListViewModel
    @ObservedObject var songListViewModel: SongListViewModel
    @ObservedObject var movieListViewModel: MovieListViewModel
    
    var body: some View {
        VStack {
            Text("Search all")
            
            Text("Movies: \(movieListViewModel.movies.count)")
            Text("Albums: \(albumListViewModel.albums.count)")
            Text("Songs: \(songListViewModel.songs.count)")
        }
    }
}

//struct SearchAllListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchAllListView()
//    }
//}
