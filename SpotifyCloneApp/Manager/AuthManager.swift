//
//  AuthManager.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import Foundation
final class AuthManager{
    
    static let shared = AuthManager()
    private var refreshingtoken = false
    enum AuthError: Error {
        case tokenNotFound
        case tokenRefreshFailed
        case tokenExchangeFailed
        case refreshTokenNotFound
        case invalidBase64Encoding
    }
    struct constants {
        static let cliendID = "b567f266c981402b99cd73cc047313aa"
        static let ClientSecret = "f8c643ea8a5e4275a1faa8808844d054"
        static let tokenAPIUrl = "https://accounts.spotify.com/api/token"
        static let redirecturi = "https://www.google.com/?client=safari"
    }
    private init(){
        
    }
    public var signInUrl : URL? {
        let scope = "user-read-private%20playlist-modify-public%20playlist-read-private%20playlist-modify-private%20user-follow-read%20user-library-read%20user-library-modify%20user-read-email"
       
        let base = "https://accounts.spotify.com/authorize"
        let string = "\(base)?response_type=code&client_id=\(constants.cliendID)&scope=\(scope)&redirect_uri=\(constants.redirecturi)&show_dialog=TRUE"
        return URL(string: string)
            
          
    }
    var isSignedIn : Bool {
        return accessToken != nil
    }
    var accessToken : String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
    var refreshToken : String? {
        return UserDefaults.standard.string(forKey: "refresh_token")
    }
    private var tokenExpresionDate : Date?{
        return UserDefaults.standard.object(forKey: "exprasionDate") as? Date
    }
    private var shouldRefreshToken : Bool {
        guard let expresionDate = tokenExpresionDate else {
            return false
        }
        let currentdate = Date()
        let fiveminutes : TimeInterval = 300
        
        return currentdate.addingTimeInterval(fiveminutes) >= expresionDate
    }
    public func exchangeCodeForToken(code : String,completion : @escaping(Bool)->Void){
        guard let url = URL(string: constants.tokenAPIUrl) else {
            return
        }
        var component = URLComponents()
        component.queryItems = [
        URLQueryItem(name: "grant_type", value: "authorization_code"),
        URLQueryItem(name: "code", value: code),
        URLQueryItem(name: "redirect_uri", value:constants.redirecturi )]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = component.query?.data(using: .utf8)
        
        
        let basictoken = constants.cliendID+":"+constants.ClientSecret
        let data = basictoken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
            completion(false)
            return
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        
      let task = URLSession.shared.dataTask(with: request) { [weak self] data,_, error in
            guard let data = data ,error == nil else{
                completion(false)
                return
            }
            do {
                let result = try JSONDecoder().decode(AuthResponse.self, from: data)
                self?.cacheToken(result : result)
                completion(true)
            }catch{
                print("olmadı krale")
                completion(false)
            }
        }
        task.resume()
        
    }
    private func cacheToken(result : AuthResponse){
        UserDefaults.standard.set(result.access_token, forKey: "access_token")
        if let refreshtoken = result.refresh_token {
            UserDefaults.standard.set(result.refresh_token, forKey: "refresh_token")
        }
       
        UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expires_in)), forKey: "expirationDate")
    }
    private var onrefreshblocks = [(String)->Void]()
    
    public func withValidToken()async throws -> String{
        if refreshingtoken {
               return try await withCheckedThrowingContinuation { continuation in
                   onrefreshblocks.append { token in
                       continuation.resume(returning: token)
                   }
               }
           }
        if shouldRefreshToken {
            let success = try await refreshifneeded()
            if success,let token = self.accessToken {
                return token
            }else {
                throw AuthError.refreshTokenNotFound
            }
            
            
               
            }else {
                if let token = self.accessToken {
                    return token
                }else {
                    throw AuthError.tokenNotFound
            }
        }
        }
    
    public func refreshifneeded() async throws -> Bool{
        guard !refreshingtoken else {
            return false
            
        }
        guard let refreshToken = self.refreshToken else {
            throw AuthError.refreshTokenNotFound
        }
        guard let url = URL(string: constants.tokenAPIUrl) else {
            throw URLError(.badURL)
        }
        refreshingtoken = true
        var component = URLComponents()
        component.queryItems = [
        URLQueryItem(name: "grant_type", value: "refresh_token"),
        URLQueryItem(name: "refresh_token", value:refreshToken )]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue( "application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = component.query?.data(using: .utf8)
        
        
        let basictoken = constants.cliendID+":"+constants.ClientSecret
        let data = basictoken.data(using: .utf8)
        guard let base64String = data?.base64EncodedString() else {
                refreshingtoken = false
            throw AuthError.invalidBase64Encoding
        }
        request.setValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        let (data1,error) = try await URLSession.shared.data(for: request)
        refreshingtoken = false
        do {
            let result = try JSONDecoder().decode(AuthResponse.self, from: data1)
            onrefreshblocks.forEach { $0(result.access_token) }
            onrefreshblocks.removeAll()
            cacheToken(result : result)
            return true
        }catch {
            onrefreshblocks.removeAll()
            throw AuthError.tokenRefreshFailed
        }
        
   
       
    }
}
