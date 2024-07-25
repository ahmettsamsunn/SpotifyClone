//
//  APICaller.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import Foundation
final class APICaller {
    
    static let shared = APICaller()
    
    private init(){
        
    }
    struct Constants {
        static let baseURL = "https://api.spotify.com/v1"
    }
    enum APIErrors{
        case failedtogetdata
    }
  


   func getfeaturedplaylist() async throws -> FeaturedPlaylist {
        
        let request = try await createRequest(with: URL(string: Constants.baseURL + "/browse/featured-playlists") , type: .GET)
        let (data,_) = try await URLSession.shared.data(for: request)
        do {
            let result = try JSONDecoder().decode(FeaturedPlaylist.self, from: data)
            print(result)
            return result
        }catch {
            throw error
        }
    }
    public func getnewreleases() async throws -> NewReleasesResponse{
        let request = try await createRequest(with: URL(string: Constants.baseURL + "/browse/new-releases?limit=50"), type: .GET)
        let (data,_) = try await URLSession.shared.data(for: request)
        do {
            let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
          
            return result
        }catch{
            print(error.localizedDescription)
            throw error
        }
        
    }
    public func getrecomendedgenres()async throws -> RecommendedGenres{
        let request = try await createRequest(with: URL(string: Constants.baseURL + "/recommendations/available-genre-seeds"), type: .GET)
        let (data,_) = try await URLSession.shared.data(for: request)
        do {
            let result = try JSONDecoder().decode(RecommendedGenres.self, from: data)
      
            return result
           
        }catch {
            throw error
        }

    }
    public func getReccomendations(genres : Set<String>) async throws -> RecommendedResponse {
        let seeds = genres.joined(separator: ",")
        let request = try await createRequest(with: URL(string: Constants.baseURL + "/recommendations?limit=2&seed_genres=\(seeds)"), type: .GET)
       
        let (data,_) = try await URLSession.shared.data(for: request)
        do {
            let result = try JSONDecoder().decode(RecommendedResponse.self, from: data)
            print(result)
            return result
        }catch {
            throw error
        }
    }
    public func getCurrentUserProfile() async throws -> UserProfile{
        let requst = try await createRequest(with: URL(string: Constants.baseURL + "/me"), type: .GET)
        let (data,_) = try await URLSession.shared.data(for: requst)
        do {
            let result = try JSONDecoder().decode(UserProfile.self, from: data)
            return result
        }catch {
            throw error
        }
       
   
    }

   /*
    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile,Error>)->Void){
        createRequest(with: URL(string: Constants.baseURL), type: .GET) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data , error == nil else {
                    
                    completion(.failure(APIErrors.failedtogetdata as! Error))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(UserProfile.self, from: data)
                    print(result)
                    completion(.success(result))
                    
                }catch{
                    print("hata====\(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    */
        enum HTTPMethod : String {
            case GET
            case POST
            }
    
    private func createRequest(with url : URL?,type : HTTPMethod)async throws -> URLRequest{
        guard let apiurl = url else {
            throw URLError(.badURL)
        }
        let token = try await AuthManager.shared.withValidToken()

        var request = URLRequest(url: apiurl)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = type.rawValue
        request.timeoutInterval = 30
        return request
       
        
    }
       
        
}


