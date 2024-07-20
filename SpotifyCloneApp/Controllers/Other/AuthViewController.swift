//
//  AuthViewController.swift
//  SpotifyCloneApp
//
//  Created by Ahmet Samsun on 16.07.2024.
//

import UIKit
import WebKit

class AuthViewController: UIViewController,WKNavigationDelegate {

    private let webview : WKWebView = {
       let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        return webview
        
    }()
    
    public var completionhandler : ((Bool)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       title = "Sing In"
        view.backgroundColor = .systemBackground
        webview.navigationDelegate = self
        view.addSubview(webview)
        guard let url = AuthManager.shared.signInUrl else {
            return
        }
        webview.load(URLRequest(url: url))
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webView.url else {
            return
        }

        guard let code = (URLComponents(string: url.absoluteString)?.queryItems?.first(where: { $0.name == "code"})?.value) else {
            return
        }
        print("code::::\(code)")
        AuthManager.shared.exchangeCodeForToken(code: code) { success in
            DispatchQueue.main.async {
                self.navigationController?.popToRootViewController(animated: true)
                self.completionhandler?(success)
            }
        }
    }
    
    
}
