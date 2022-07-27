//
//  AlbumForSongViewModel.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 27.07.22.
//

import Foundation

class AlbumForSongViewModel: ObservableObject {
    
    @Published var album: Album?
    @Published var state: FetchState = .good
    
    let service = APIService()
    
    func fetch(song: Song) {
        
        let albumID = song.collectionID
        
        service.fetchAlbum(with: albumID) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        
                        let albums = results.results
                        
                        self?.album = albums.first
                        self?.state = .good
                        print("fetched \(results.resultCount) songs for albumID: \(albumID)")
                        
                    case .failure(let error):
                        print("Could not load: \(error)")
                        self?.state = .error(error.localizedDescription)
                }
            }
        }
        
        
    }
}
