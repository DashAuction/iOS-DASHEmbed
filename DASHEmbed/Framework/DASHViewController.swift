//
//  ViewController.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//

import UIKit
import WebKit

class DASHViewController: UIViewController {
    
    var webView: WKWebView!
    
    private var config: DASHConfig?
    private let baseURLString = "https://web.dashapp.io/auctions/"
    
    static func instantiate(with config: DASHConfig) -> DASHViewController {
        let storyboard = UIStoryboard(name: "DASH", bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? DASHViewController else {
            fatalError("Unable to instantiate DASHViewController.")
        }
        viewController.config = config
        
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
        webView.navigationDelegate = self
        
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
        
        let fullURLString = baseURLString.appending(config.teamIdentifier)
        if let url = URL(string: fullURLString) {
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    
}

extension DASHViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Starting navigation")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished navigation: \(navigation)")
    }
}

