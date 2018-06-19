//
//  ViewController.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//

import UIKit
import WebKit

class DASHViewController: UIViewController {
    
    private let baseURLString = "https://web.dashapp.io/auctions/"
    private let distributorQueryName = "distributorIdentifier"
    private let applicationQueryName = "applicationIdentifier"
    private let emailQueryName = "userEmail"
    private let pushQueryName = "pushToken"

    private var webView: WKWebView!
    private var config: DASHConfig?
    private var userInfo: DASH.UserInfo?
    
    static func instantiate(with config: DASHConfig, userInfo: DASH.UserInfo) -> DASHViewController {
        let storyboard = UIStoryboard(name: "DASH", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DASHViewController else {
            fatalError("Unable to instantiate DASHViewController.")
        }
        viewController.config = config
        viewController.userInfo = userInfo
        
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebView()
    }
    
    // MARK: Private
    
    private func setupWebView() {
        // Create WKWebView in code, because IB has issues before iOS 11
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        let horizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "|[webView]|",
                                                                  options: [],
                                                                  metrics: nil,
                                                                  views: ["webView": webView])
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[webView]|",
                                                                 options: [],
                                                                 metrics: nil,
                                                                 views: ["webView": webView])
        view.addConstraints(horizontalContraints)
        view.addConstraints(verticalConstraints)
    }
    
    private func loadWebView() {
        guard let config = config else { fatalError("A DASHConfig is required before using DASHViewController")}
        
        let teamURLString = baseURLString.appending(config.teamIdentifier)
        if let url = URL(string: teamURLString) {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
            var queryItems = [URLQueryItem]()
            
            //Add default query items
            let distributorQueryItem = URLQueryItem(name: distributorQueryName, value: config.distributorIdentifier)
            queryItems.append(distributorQueryItem)
            let applicationQueryItem = URLQueryItem(name: applicationQueryName, value: config.applicationIdentifier)
            queryItems.append(applicationQueryItem)
            
            //Add user email if provided
            if let userEmail = userInfo?.userEmail {
                let userEmailQueryItem = URLQueryItem(name: emailQueryName, value: userEmail)
                queryItems.append(userEmailQueryItem)
            }
            
            //Add push token if provided
            if let pushToken = userInfo?.pushTokenString {
                let pushQueryItem = URLQueryItem(name: pushQueryName, value: pushToken)
                queryItems.append(pushQueryItem)
            }
            
            urlComponents?.queryItems = queryItems
            
            if let fullURL = urlComponents?.url {
                let urlRequest = URLRequest(url: fullURL)
                webView.load(urlRequest)
            }
        }
    }
}
