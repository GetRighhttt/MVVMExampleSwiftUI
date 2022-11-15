//
//  ApiRequests.swift
//  MvvmMusic
//
//  Created by Stefan Bayne on 11/15/22.
//

import Foundation

class DataModel {
    
    private var dataTask: URLSessionDataTask? // holds the data task

    func loadSongs(searchTerm: String, completion: @escaping(([SongModel]) -> Void)) {
        dataTask?.cancel() // cancels any task at first
        
        guard let url = buildUrl(forTerm: searchTerm) else {
            completion([])
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) {data, _, _ in
            guard let data = data else {
                completion([])
                return
            }
            
            if let songResponse = try? JSONDecoder().decode(SongResponseModel.self, from: data) {
                completion(songResponse.songs)
            }
        }
        dataTask?.resume()
    }
    
    /*
     We need methods to build the URL and load songs from API.
     url = https://itunes.apple.com/search?term=coldplay&entity=song
     Need query items based on URL (term and entity)
     */
    private func buildUrl(forTerm searchTerm: String) -> URL? {
        
        guard !searchTerm.isEmpty else { return nil } // if empty return nil
        
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "entity", value: "song")
        ]
        var components = URLComponents(string: "https://itunes.apple.com/search")
        components?.queryItems = queryItems
        
        return components?.url
    }
}
