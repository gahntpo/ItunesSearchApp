//
//  AlbumListViewModel.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 25.07.22.
//

import Foundation
import Combine

// https://itunes.apple.com/search?term=jack+johnson&entity=album&limit=5&offset=10
// https://itunes.apple.com/search?term=jack+johnson&entity=song&limit=5
// https://itunes.apple.com/search?term=jack+johnson&entity=movie&limit=5

class AlbumListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var albums: [Album] = [Album]()
    
    @Published var state: FetchState = .good
    
    let limit: Int = 20
    var page: Int = 0
    
    let service = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {

        $searchTerm
            .removeDuplicates()
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.clear()
                self?.fetchAlbums(for: term)
            }.store(in: &subscriptions)
        
    }
    
    func clear() {
        state = .good
        albums = []
        page = 0
    }
    
    func loadMore() {
        fetchAlbums(for: searchTerm)
    }

    func fetchAlbums(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        service.fetchAlbums(searchTerm: searchTerm, page: page, limit: limit) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        for album in results.results {
                            self?.albums.append(album)
                        }
                        self?.page += 1
                        self?.state = (results.results.count == self?.limit) ? .good : .loadedAll
                        print("fetched albums \(results.resultCount)")
                        
                    case .failure(let error):
                        print("error loading albums: \(error)")
                        self?.state = .error("Could not load: \(error.localizedDescription)")
                }
            }
        }
    }
    
    static func example() -> AlbumListViewModel {
        let vm = AlbumListViewModel()
        vm.albums = [Album.example()]
        return vm
    }
}


