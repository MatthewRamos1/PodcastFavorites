//
//  DetailViewController.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/17/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var podcastImage: UIImageView!
    @IBOutlet weak var podcastName: UILabel!
    @IBOutlet weak var artistName: UILabel!
    
    var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        
    }
    
    func updateUI() {
        guard let detailVCPodcast = podcast else {
            fatalError("Error: Can't pull Podcast, check prepare for segue")
        }
        podcastName.text = detailVCPodcast.collectionName
        artistName.text = detailVCPodcast.artistName
        podcastImage.getImage(with: detailVCPodcast.artworkUrl600, completion: { [weak self] (result) in
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
        }
    )
    }
    
    @IBAction func addFavButtonPressed(_ sender: UIBarButtonItem) {
        guard let detailVCPodcast = podcast else {
            fatalError("Error: Can't pull Podcast, check prepare for segue")
        }
        PodcastAPI.postPodcast(podcast: Podcast(trackId: detailVCPodcast.trackId, collectionName: detailVCPodcast.collectionName, artworkUrl600: detailVCPodcast.artworkUrl600, artistName: detailVCPodcast.artistName, favoritedBy: "Matthew Ramos"), completion: { [weak self, weak sender] (result) in
            switch result {
            case .failure(let appError):
            DispatchQueue.main.async {
                    self?.showAlert(title: "Failed to Post Favorite", message: "\(appError)")
                    sender?.isEnabled = true
                  }
                case .success:
                  DispatchQueue.main.async {
                    self?.showAlert(title: "Favorite Posted", message: "Your favorite has been posted to favorites.")
                    }
                }
            }
        )
        }
}
