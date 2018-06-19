//
//  ExampleViewController.swift
//  DASHEmbed
//
//  Copyright © 2018 DASH. All rights reserved.
//
//  Used to show how to implement DASHEmbed web view

import UIKit
import UserNotifications

class ExampleViewController: UIViewController {
    
    @IBOutlet var pushStatusLabel: UILabel!
    @IBOutlet var userEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Update Push Status
        updatePushStatusLabel()
    }
    
    // MARK: Actions
    
    @IBAction private func presentModally() {
        let dashViewController = DASH.team.dashViewController()
        
        //Add a close button
        let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeDASHModal))
        dashViewController.navigationItem.leftBarButtonItem = closeButton
        
        //Present
        let navigationController = UINavigationController(rootViewController: dashViewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    @IBAction private func pushNavigation() {
        let dashViewController = DASH.team.dashViewController()
        navigationController?.pushViewController(dashViewController, animated: true)
    }
    
    @IBAction private func requestPushAuthorization() {
        registerForPushNotifications()
    }
    
    @objc private func closeDASHModal() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func userEmailUpdated(sender: UITextField) {
        DASH.team.setUserEmail(sender.text)
    }
    
    // MARK: - Private
    
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] (granted, error) in
            self?.updatePushStatusLabel()
            
            //Check if permission granted
            guard granted else { return }
            
            //Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
    
    private func updatePushStatusLabel() {
        UNUserNotificationCenter.current().getNotificationSettings { [weak self] (settings) in
            DispatchQueue.main.async {
                let status: String
                switch settings.authorizationStatus {
                case .authorized:
                    status = "Authorized"
                case .denied:
                    status = "Denied"
                case .notDetermined:
                    status = "Not Determined"
                }
                self?.pushStatusLabel.text = "Push Status: \(status)"
            }
        }
    }
}
