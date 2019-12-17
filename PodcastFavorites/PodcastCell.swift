//
//  PodcastCell.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/17/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import UIKit

class PodcastCell: UITableViewCell {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var podcastArtistName: UILabel!
    
    func configureCell(podcast: Podcast) {
        podcastName.text = podcast.collectionName
        podcastArtistName.text = podcast.artistName
        podcastImage.getImage(with: podcast.artworkUrl600, completion: { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.podcastImage.image = UIImage(systemName: "xmark.icloud")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.podcastImage.image = image
                }
            }
        })
    }
}
