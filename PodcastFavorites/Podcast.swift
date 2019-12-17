//
//  Podcast.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/17/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import Foundation

struct PodcastData: Decodable {
    let results: [Podcast]
}

struct Podcast: Decodable {
    let trackId : Int
    let collectionName: String
    let artworkUrl600: String
    let artistName: String
}
