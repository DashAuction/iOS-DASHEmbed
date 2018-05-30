# DASH

## Purpose

This library provides an easy way to embed the DASH mobile experience into an iOS application.

## Usage

### Create a DASHConfig

Create a DASHConfig. This is used to initialize the DASH library with needed information.

```swift
let bundleIdentifier = Bundle.main.bundleIdentifier ?? "io.dashapp.DASHEmbed"
let dashConfig = DASHConfig(teamIdentifier: "fcdallas", distributorIdentifier: "DASH_DISTRIBUTOR", applicationIdentifier: bundleIdentifier)
```
### Initialize the DASH library

Initialize library either using the singleton or instance.

```swift
DASH.team.start(with: dashConfig)
```
```swift
let dash = DASH()
dash.start(with: dashConfig)
```

### Set the push token to enable outbid notifications (Work in progress)

```swift
//Sets the user's push token for outbid notifications
DASH.team.setUserPushToken(with: deviceToken)
```

### Display the provided DASHViewController

```swift
let dashViewController = DASH.team.dashViewController()

//Add a close button if needed
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

Check out the [Current Documentation](https://bitbucket.org/dashdev/dash-embed-ios/raw/21b09d1d6620a0594e88aea498cfa46a4717b43b/Documentation/DASHAuctions_V1.pdf)
