//
//  Album.swift
//  ItunesSearchApp
//
//  Created by Karin Prater on 25.07.22.
//

import Foundation

// MARK: - AlbumResult
struct AlbumResult: Codable {
    let resultCount: Int
    let results: [Album]
}

// MARK: - Result
struct Album: Codable, Identifiable {
    let wrapperType, collectionType: String
    let id: Int
    let artistID: Int
    let amgArtistID: Int?
    let artistName, collectionName, collectionCensoredName: String
    let artistViewURL: String?
    let collectionViewURL: String
    let artworkUrl60, artworkUrl100: String
    let collectionPrice: Double?
    let collectionExplicitness: String
    let trackCount: Int
    let copyright: String?
    let country, currency: String
    let releaseDate: String
    let primaryGenreName: String

    enum CodingKeys: String, CodingKey {
        case wrapperType, collectionType
        case artistID = "artistId"
        case id = "collectionId"
        case amgArtistID = "amgArtistId"
        case artistName, collectionName, collectionCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case artworkUrl60, artworkUrl100, collectionPrice, collectionExplicitness, trackCount, copyright, country, currency, releaseDate, primaryGenreName
    }
    
    static func example() -> Album {
        
        Album(wrapperType: "collection", collectionType: "Album", id: 1, artistID: 2, amgArtistID: 3,
              artistName: "Jack Johnson & Friends",
              collectionName: "Best of Kokua Festival (A Benefit for the Kokua Hawaii Foundation)", collectionCensoredName: "",
              artistViewURL: nil, collectionViewURL: "https://music.apple.com/us/album/jack-johnson-friends-best-of-kokua-festival-a/1440752312?uo=4",
              artworkUrl60: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg",
              artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/100x100bb.jpg",
              collectionPrice: 8.99, collectionExplicitness: "", trackCount: 15, copyright: nil, country: "USA", currency: "USD", releaseDate: "2012-01-01T08:00:00Z", primaryGenreName: "Rock")
        
    }
}

/*
 {"wrapperType":"collection", "collectionType":"Album", "artistId":909253, "collectionId":1440752312, "amgArtistId":468749, "artistName":"Jack Johnson", "collectionName":"Jack Johnson & Friends - Best of Kokua Festival (A Benefit for the Kokua Hawaii Foundation)", "collectionCensoredName":"Jack Johnson & Friends - Best of Kokua Festival (A Benefit for the Kokua Hawaii Foundation)", "artistViewUrl":"https://music.apple.com/us/artist/jack-johnson/909253?uo=4", "collectionViewUrl":"https://music.apple.com/us/album/jack-johnson-friends-best-of-kokua-festival-a/1440752312?uo=4", "artworkUrl60":"https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/60x60bb.jpg", "artworkUrl100":"https://is2-ssl.mzstatic.com/image/thumb/Music114/v4/43/d0/ba/43d0ba6b-6470-ad2d-0c84-171c1daea838/12UMGIM10699.rgb.jpg/100x100bb.jpg", "collectionPrice":8.99, "collectionExplicitness":"notExplicit", "trackCount":15, "copyright":"This Compilation ℗ 2012 Brushfire Records Inc", "country":"USA", "currency":"USD", "releaseDate":"2012-01-01T08:00:00Z", "primaryGenreName":"Rock"},
 
 
 */
