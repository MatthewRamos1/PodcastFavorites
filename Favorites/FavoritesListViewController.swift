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
        getFavorites()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Error: Check prepare for segue")
        }
        detailVC.podcast = favorites[indexPath.row]
    }
    
    func getFavorites() {
        PodcastAPI.fetchFavorites(completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                        self?.showAlert(title: "Error: Could not read data", message: "\(appError)")
                    }
                case .success(let favorites):
                        self?.favorites = favorites
                    }
            }
        )
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
