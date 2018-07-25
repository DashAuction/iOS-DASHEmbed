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
    @IBOutlet var userEmailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Update Push Status
        updatePushStatusLabel()
        
        // Put this in so I don't have to tap the request every time.  Please delete as needed.
        registerForPushNotifications()
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
    
    @IBAction private func setUserEmailTapped() {
        presentEntryAlert(with: "Set Email", message: "Set the user email.", currentValue: nil) { (email) in
            DASH.team.setUserEmail(email)
            self.userEmailLabel.text = "Email: \(email ?? "Not Set")"
        }
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
    
    private func presentEntryAlert(with title: String, message: String, currentValue: String? = nil, completion: @escaping (String?) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = title
            textField.text = currentValue
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (_) in
            let textFieldText = alert.textFields?.first?.text
            completion(textFieldText)
        }))
        present(alert, animated: true, completion: nil)
    }
}
