//
//  Podcast.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/17/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import Foundation

struct PodcastData: Codable {
    let results: [Podcast]
}

struct Podcast: Codable {
    let trackId : Int
    let favoritedBy: String
    let collectionName: String
    let artworkUrl600: String
}
