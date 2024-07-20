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
        enum HTTPMethod : String {
            case GET
            case POST
        }
        private func createRequest(with url : URL?,type : HTTPMethod,completion : @escaping(URLRequest)->Void){
            AuthManager.shared.withValidToken { token in
                guard let apiurl = url else {
                    return
                }
                var request = URLRequest(url: apiurl)
                request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                request.httpMethod = type.rawValue
                request.timeoutInterval = 30
                completion(request)
            }
            
        }
        
}

