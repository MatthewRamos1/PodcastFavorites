//
//  ViewController.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/17/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchPodcasts(searchQuery: "swift")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("Error: Check prepare for segue")
        }
        detailVC.podcast = podcasts[indexPath.row]
    }

    func searchPodcasts (searchQuery: String) {
        PodcastAPI.fetchPodcasts(searchQuery: searchQuery, completion: { [weak self] (result) in
            switch result {
            case .failure(let appError):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error: Could not read data", message: "\(appError)")
                }
            case .success(let podcasts):
                //DispatchQueue.main.async {
                    self?.podcasts = podcasts
                //}
                }
            }
        )
        }
    }

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        podcasts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as? PodcastCell else {
            fatalError("Couldn't pull PodcastCells")
        }
        let
        podcast = podcasts[indexPath.row]
        cell.configureCell(podcast: podcast)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        204
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchQuery = searchBar.text else {
            showAlert(title: "Error", message: "Text is required")
            return
        }
        searchPodcasts(searchQuery: searchQuery)
    }
}
