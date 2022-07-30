//
//  MovieListViewModel.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 25.07.22.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var searchTerm: String = ""
    @Published var movies: [Movie] = [Movie]()
    @Published var state: FetchState = .good
    
    private let service = APIService()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {

        $searchTerm
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] term in
                self?.state = .good
                self?.movies = []
                self?.fetchMovies(for: term)
            }.store(in: &subscriptions)
        
    }
    
    func fetchMovies(for searchTerm: String) {
        
        guard !searchTerm.isEmpty else {
            return
        }
        
        guard state == FetchState.good else {
            return
        }
        
        state = .isLoading
        
        service.fetchMovies(searchTerm: searchTerm) { [weak self]  result in
            DispatchQueue.main.async {
                switch result {
                    case .success(let results):
                        self?.movies = results.results
                
                        if results.resultCount == 0 {
                            self?.state = .noResults
                        } else {
                            self?.state = .good
                        }
                      
                        print("fetched movies \(results.resultCount) - \(results.results.count)")
                        
                    case .failure(let error):
                        print("error loading movies: \(error)")
                        self?.state = .error(error.localizedDescription)
                }
            }
        }
    }
    
    func loadMore() {
        fetchMovies(for: searchTerm)
    }
    
    static func example() -> MovieListViewModel {
        let vm = MovieListViewModel()
        vm.movies = [Movie.example()]
        return vm
    }
}
