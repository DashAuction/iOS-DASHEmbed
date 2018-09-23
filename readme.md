# DASH

## Purpose

This library provides an easy way to embed the DASH mobile experience into an iOS application. For more information check out [DASH](http://www.dashapp.io)

## Installation

#### The easiest way to use DASHEmbed: Cocoapods

```ruby
pod 'DASHEmbed'
```

#### Manual Install: Static Framework

1. Build the static framework using the "DASHEmbed-Aggregate" target. (Builds to root of repository)
2. Build the resource bundle using the "DASHResources" target. (Builds to products)
3. Copy both DASHEmbed.framework and DASHEmbed.resources into your project (but don't add it to any targets).
4. Add DASHEmbed.framework to the "Embedded Binaries" list of the target you wish to use with DASHEmbed. This should automatically add it to the "Linked Frameworks and Libaries" list.
5. As DASHEmbed is written in Swift, be sure you include the Swift standard libraries if you aren't already. (You'll know if you encounter a runtime error regarding swift libraries when trying to use DASHEmbed). Simply set "Always Embed Swift Standard Libraries" to "YES" in your target's build settings. This will include everything needed.

#### Manual Install: Source

1. Copy everything under "DASHEmbed/Framework" into your project.

## Usage

### Requirements

##### iOS 10+, Swift 4.1

##### User location is used for future location based features.

To enable, set a description for the NSLocationWhenInUseUsageDescription plist key.

##### To enable push notification functionality

We will need a 1) Push notification Encryption Key (.p8), 2) Key ID, 3) Developer Team Id, and 4) App bundle identifier from the [Apple Developer Portal](https://developer.apple.com). For information on obtaining these assets see the "Obtain an Encryption Key and Key ID from Apple" section on [Establishing a Token-Based Connection to APNs](https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/establishing_a_token_based_connection_to_apns)

Please note that the DASH framework and associated notifications do not affect badge counts.

After receiving the push assets above, we will provide you with an App ID to use in the app.

### Create a DASHConfig

Create a DASHConfig. This is used to initialize the DASH library with needed information.

```swift
let appId = "APP_ID"
let dashConfig = DASHConfig(appId: appId)
```

A second initializer allow you to use the DASH development servers to test.

```swift
let dashConfig: DASHConfig
#if DEBUG
dashConfig = DASHConfig(appId: appId, useDevelopmentServers: true)
#else
dashConfig = DASHConfig(appId: appId)
#endif
```

### Initialize the DASH library

Initialize library using the singleton.

```swift
DASH.team.start(with: dashConfig)
```

### Set the push token to enable outbid notifications

```swift
//Sets the user's push token for outbid notifications
DASH.team.setUserPushToken(with: deviceToken)
```

### Handling push notifications

```swift
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
    //Check if DASH can handle the notification
    if DASH.team.canHandleNotification(response.notification) {
        DASH.team.setNotificationData(from: response.notification)
        //Trigger the display of the DASHViewController in your app
    }

    //Else, Handle other notifications

    completionHandler()
}
```

### Set the user's email to enable autofill of email. DASH also determines if this user already has a DASH account

```swift
let email = "test@email.com"
DASH.team.setUserEmail(email)
```

### Display the provided DASHViewController

```swift
guard let dashViewController = DASH.team.dashViewController() else { return }
dashViewController.delegate = self //Optionally set delegate

//Add a close button
let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeDASHModal))
dashViewController.navigationItem.leftBarButtonItem = closeButton
```
Display modally

```swift
//Present
let navigationController = UINavigationController(rootViewController: dashViewController)
present(navigationController, animated: true, completion: nil)
```
Or push on a navigation stack

```swift
navigationController?.pushViewController(dashViewController, animated: true)
```

Check out the [Current Documentation](https://github.com/DashAuction/iOS-DASHEmbed/raw/master/Documentation/DASHAuctions_V1.1.pdf)
