//
//  FavoritesListViewController.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/18/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var favorites = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension FavoritesListViewController:
UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as? PodcastCell else {
        fatalError("Couldn't pull PodcastCells")
    }
    let
    favorite = favorites[indexPath.row]
    cell.configureCell(podcast: favorite)
    return cell
}
}

extension FavoritesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        204
    }
}
