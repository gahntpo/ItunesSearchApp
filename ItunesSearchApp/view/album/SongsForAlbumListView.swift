//
//  SongsForAlbumListView.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 27.07.22.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsViewModel: SongsForAlbumListViewModel
    let selectedSong: Song?
    
    var body: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView {
                
                if songsViewModel.state == .isLoading {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else if songsViewModel.songs.count > 0 {
                    Group {
                        if #available(iOS 16.0, *) {
                            SongsGridView(songs: songsViewModel.songs, selectedSong: selectedSong)
                        } else {
                            SongStackView(songs: songsViewModel.songs, selectedSong: selectedSong)
                        }
                    }
                    .padding(.top, 30)
                    
                    .onAppear {
                        if let song = selectedSong {
                            withAnimation {
                                proxy.scrollTo(song.trackNumber, anchor: .center)
                            }
                        }
                    }
                }
            }
        }
    }
}

@available(iOS 16.0, *)
struct SongsGridView: View {
    
    let songs: [Song]
    let selectedSong: Song?
    
    var body: some View {
        Grid(horizontalSpacing: 20) {
            ForEach(songs) { song in
                GridRow {
                    Text("\(song.trackNumber)")
                        .font(.footnote)
                        .gridColumnAlignment(.trailing)
                    
                    Text(song.trackName)
                        .lineLimit(2)
                        .gridColumnAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(formattedDuration(time: song.trackTimeMillis))
                        .font(.footnote)
                    
                    BuySongButton(urlString: song.previewURL,
                                  price: song.trackPrice,
                                  currency: song.currency)
                    .padding(.trailing)
                }
                .foregroundColor(selectedSong?.id == song.id ? Color.accentColor : Color.black)
                .id(song.trackNumber)
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
                
            }
        }
        .padding([.bottom, .leading])
    }
}

struct SongStackView: View {
    
    let songs: [Song]
    let selectedSong: Song?
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(songs) { song in
                HStack(spacing: 10) {
                    Text("\(song.trackNumber)")
                        .font(.footnote)
                        .frame(width: 25, alignment: .trailing)
                    
                    Text(song.trackName)
                        .lineLimit(2)
                    
                    Spacer()
                    
                    Text(formattedDuration(time: song.trackTimeMillis))
                        .font(.footnote)
                        .frame(width: 40)
                    
                    BuySongButton(urlString: song.previewURL,
                                  price: song.trackPrice,
                                  currency: song.currency)
                    
                    .padding(.trailing)
                }
                .foregroundColor(selectedSong?.id == song.id ? Color.accentColor : Color.black)
                //.padding(.bottom, 10)
                .id(song.trackNumber)
                
                Divider()
            }
        }
    }
}


fileprivate func formattedDuration(time: Int) -> String {
    
    let timeInSeconds = time / 1000
    
    let interval = TimeInterval(timeInSeconds)
    let formatter = DateComponentsFormatter()
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [.minute, .second]
    formatter.unitsStyle = .positional
    
    return formatter.string(from: interval) ?? ""
}

struct SongsForAlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        SongsForAlbumListView(songsViewModel: SongsForAlbumListViewModel.example(),
                              selectedSong: nil)
    }
}
