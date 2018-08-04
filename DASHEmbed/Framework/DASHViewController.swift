//
//  ViewController.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//

import UIKit
import WebKit

public protocol DASHViewControllerDelegate: class {
    /// Called when the DASH view controller encounters an error.
    func dashViewController(_ dashViewController: DASHViewController, didFailWith error: DASH.Error)
}

public class DASHViewController: UIViewController {
    
    private let baseURLString = "https://dev-web.dashapp.io/app"
    private let applicationQueryName = "appId"
    private let platformQueryName = "platformId"
    private let platformQueryValue = "ios"
    private let emailQueryName = "email"
    private let pushQueryName = "pushId"

    private var webView: WKWebView!
    private var config: DASHConfig?
    private var userInfo: DASH.UserInfo?
    private var notificationData: [String: Any]?
    
    public weak var delegate: DASHViewControllerDelegate?
    
    static func instantiate(with config: DASHConfig, userInfo: DASH.UserInfo, notificationData: [String: Any]?) -> DASHViewController? {
        let storyboard = UIStoryboard(name: "DASH", bundle: Bundle.frameworkResourceBundle)
        guard let viewController = storyboard.instantiateInitialViewController() as? DASHViewController else {
            print("Unable to instantiate DASHViewController.")
            return nil
        }
        
        viewController.config = config
        viewController.userInfo = userInfo
        viewController.notificationData = notificationData
        
        return viewController
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadWebView()
    }
    
    /// Updates the view controller with notification data. Used internally.
    public func updateNotificationData(with data: [String: Any]?) {
        notificationData = data
        reloadInterface(startFromBeginning: true) //Reload the web view to the correct page
    }
    
    /// Refreshes the current page. If startFromBeginning is true, the interface is reloaded to the beginning state.
    public func reloadInterface(startFromBeginning: Bool = false) {
        if startFromBeginning {
            loadWebView()
        } else {
            webView.reload()
        }
    }
    
    // MARK: Private
    
    private func setupWebView() {
        // Create WKWebView in code, because IB has issues before iOS 11
        let configuration = WKWebViewConfiguration()
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.navigationDelegate = self
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webView)
        let horizontalContraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[webView]|",
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
        guard let config = config else {
            print("A DASHConfig is required before using DASHViewController")
            delegate?.dashViewController(self, didFailWith: .unableToLoad)
            return
        }
        
        if let url = URL(string: baseURLString) {
            var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
            
            var queryItems = [URLQueryItem]()
            
            //Add default query items
            let applicationQueryItem = URLQueryItem(name: applicationQueryName, value: config.appId)
            queryItems.append(applicationQueryItem)
            let platformQueryItem = URLQueryItem(name: platformQueryName, value: platformQueryValue)
            queryItems.append(platformQueryItem)
            
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
            
            //Add the notification data as query parameters if present
            if let notificationData = notificationData {
                for (key, value) in notificationData {
                    let notificationQuery = URLQueryItem(name: key, value: String(describing: value))
                    queryItems.append(notificationQuery)
                }
            }
            
            urlComponents?.queryItems = queryItems
            
            if let fullURL = urlComponents?.url {
                let urlRequest = URLRequest(url: fullURL)
                webView.load(urlRequest)
            }
        }
    }
}

extension DASHViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        let nsError = error as NSError
        if nsError.code == NSURLErrorNotConnectedToInternet {
            delegate?.dashViewController(self, didFailWith: .noInternet)
            return
        }
        
        delegate?.dashViewController(self, didFailWith: .unableToLoad)
    }
}
