//
//  SongsForAlbumListView.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 27.07.22.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsViewModel: SongsForAlbumListViewModel
    
    var body: some View {
        ScrollView {
            
            if songsViewModel.state == .isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else {
                
                Grid(horizontalSpacing: 20) {
                    ForEach(songsViewModel.songs) { song in
                        GridRow {
                            Text("\(song.trackNumber)")
                                .font(.footnote)
                                .gridColumnAlignment(.trailing)
                            
                            Text(song.trackName)
                                .gridColumnAlignment(.leading)
                            
                            Spacer()
                            Text(formattedDuration(time: song.trackTimeMillis))
                                .font(.footnote)
                             
                            
                            BuySongButton(urlString: song.previewURL,
                                          price: song.trackPrice,
                                          currency: song.currency)
                        }
                        
                        Divider()
                    }
                }
                .padding([.vertical, .leading])
            }
        }
    }
    
    func formattedDuration(time: Int) -> String {
        
        let timeInSeconds = time / 1000
        
        let interval = TimeInterval(timeInSeconds)
        let formatter = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        return formatter.string(from: interval) ?? ""
    }
}

struct SongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumListView(songsViewModel: SongsForAlbumListViewModel.example())
    }
}
