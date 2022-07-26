//
//  ContentView.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 25.07.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.note")
                }
            
            MovieSearchListView()
                .tabItem {
                    Label("Movies", systemImage: "tv")
                }
        }
          
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
