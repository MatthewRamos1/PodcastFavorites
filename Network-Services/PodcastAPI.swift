//
//  PodcastSearchAPI.swift
//  PodcastFavorites
//
//  Created by Matthew Ramos on 12/17/19.
//  Copyright © 2019 Matthew Ramos. All rights reserved.
//

import Foundation

struct PodcastAPI {
    
    static func fetchPodcasts (searchQuery: String, completion: @escaping (Result<[Podcast],AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "swift"
        let podcastEndPointURL = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(searchQuery)"
        
        guard let url = URL(string: podcastEndPointURL) else {
            completion(.failure(.badURL(podcastEndPointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode(PodcastData.self, from: data)
                    let podcasts = searchResults.results
                    completion(.success(podcasts))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func postPodcast (podcast: Podcast, completion: @escaping (Result<Bool, AppError>) -> ()) {
        
        let podcastURLString = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        
        guard let url = URL(string: podcastURLString) else {
            return
        }
        
        do {
            let data = try JSONEncoder().encode(podcast)
            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            request.httpMethod = "POST"
            
            NetworkHelper.shared.performDataTask(with: request, completion: { (result) in
                switch result {
                case .failure(let appError):
                    completion(.failure(.networkClientError(appError)))
                case .success:
                    completion(.success(true))
                }
            })
        } catch {
            completion(.failure(.encodingError(error)))
        }
    }
    
    static func getFavorites (completion: @escaping (Result<[Podcast], AppError>) -> ()) {
        let podcastEndPointURL = "https://5c2e2a592fffe80014bd6904.mockapi.io/api/v1/favorites"
        guard let url = URL(string: podcastEndPointURL) else {
            completion(.failure(.badURL(podcastEndPointURL)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request, completion: { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let podcastData = try JSONDecoder().decode(PodcastData.self, from: data)
                    let podcasts = podcastData.results
                    let favorites = podcasts.filter { $0.favoritedBy == "Matthew Ramos"}
                    completion(.success(favorites))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
        )
    }
}
