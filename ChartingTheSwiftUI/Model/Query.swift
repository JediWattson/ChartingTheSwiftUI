//
//  Query.swift
//  ChartingTheSwiftUI
//
//  Created by Field Employee on 10/6/20.
//  Copyright © 2020 JediWattson. All rights reserved.
//

import UIKit

struct Query: Codable {
    var feed: Feed
    enum CodingKeys: String, CodingKey {
        case feed
    }
}

struct Feed: Codable {
    var results: [AlbumObj]
    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct AlbumObj: Codable {
    var id: String
    var artistName: String
    var releaseDate: String
    var artworkUrl100: String
    var genres: [Genres]
    var name: String
    var contentAdvisoryRating: String?
    var isLoved: Bool = false
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id, artistName, releaseDate, artworkUrl100, name, genres, contentAdvisoryRating
    }
}

struct Genres: Codable {
    var name: String
    enum CodingKeys: String, CodingKey {
        case name
    }
}
