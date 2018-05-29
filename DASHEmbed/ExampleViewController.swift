//
//  ExampleViewController.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//
//  Used to show how to implement DASHEmbed web view

import UIKit

class ExampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Configure DASH Instance
        let bundleIdentifier = Bundle.main.bundleIdentifier ?? "io.dashapp.DASHEmbed"
        let dashConfig = DASHConfig(userEmail: "ryan@dashapp.io", teamIdentifier: "fcdallas", pushDeviceToken: nil, distrubutorIdentifier: "DASH_DISTRIBUTOR", applicationIdentifier: bundleIdentifier)
        DASH.team.start(with: dashConfig)
    }
    
    // MARK: Actions
    
    @IBAction func presentModally() {
        let dashViewController = DASH.team.dashViewController()
        
        //Add a close button
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeDASHModal))
        dashViewController.navigationItem.leftBarButtonItem = closeButton
        
        //Present
        let navigationController = UINavigationController(rootViewController: dashViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction func pushNavigation() {
        let dashViewController = DASH.team.dashViewController()
        navigationController?.pushViewController(dashViewController, animated: true)
    }
    
    @objc func closeDASHModal() {
        dismiss(animated: true, completion: nil)
    }
}
