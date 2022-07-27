//
//  SongDetailView.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 27.07.22.
//

import SwiftUI

struct SongDetailView: View {
    
    @StateObject var songsViewModel: SongsForAlbumListViewModel
    @StateObject var albumsViewModel = AlbumForSongViewModel()
    
    let song: Song
    
    init(song: Song) {
        self.song = song
        let albumID = song.collectionID
        self._songsViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: albumID))
    }
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            if let album = albumsViewModel.album {
                AlbumHeaderDetailView(album: album)
                
            } else if albumsViewModel.state == .isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
            
             Divider()
            
            SongsForAlbumListView(songsViewModel: songsViewModel,
                                  selectedSong: song)
            
        }
        .onAppear {
            songsViewModel.fetch()
            albumsViewModel.fetch(song: song)
        }
    }
}

struct SongDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SongDetailView(song: Song.example())
    }
}
