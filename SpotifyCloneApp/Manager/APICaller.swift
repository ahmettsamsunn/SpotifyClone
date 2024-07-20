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
        static let baseURL = "https://api.spotify.com/v1/me"
    }
    enum APIErrors{
        case failedtogetdata
    }
    public func getCurrentUserProfile() async throws -> UserProfile{
        let requst = try await createRequest(with: URL(string: Constants.baseURL), type: .GET)
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


