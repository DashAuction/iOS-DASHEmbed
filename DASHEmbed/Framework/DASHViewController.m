//
//  DASHViewController.m
//  DASHEmbed
//
//  Created by Ryan Gant on 11/24/19.
//  Copyright © 2019 DASH. All rights reserved.
//

#import "DASHViewController.h"
#import "DASHConfig.h"
#import "DASHUserInfo.h"
#import "NSBundle+DASHAdditions.h"
@import WebKit;

static NSString *const DASBaseDevelopmentURLString = @"https://dev-web.dashapp.io/app";
static NSString *const DASBaseURLString = @"https://web.dashapp.io/app";
static NSString *const DASApplicationQueryName = @"appId";
static NSString *const DASPlatformQueryName = @"platformId";
static NSString *const DASPlatformQueryValue = @"ios";
static NSString *const DASEmailQueryName = @"email";
static NSString *const DASPushQueryName = @"pushId";

@interface DASHViewController () <WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) DASHConfig *config;
@property (nonatomic, strong) DASHUserInfo *userInfo;
@property (nonatomic, strong) NSDictionary<NSString *, id> *notificationData;

@end

@implementation DASHViewController

+ (instancetype)instantiateWithConfig:(DASHConfig *)config userInfo:(DASHUserInfo *)userInfo notificationData:(NSDictionary<NSString *, id> *)notificationData {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DASH" bundle:[NSBundle frameworkResourceBundle]];
    DASHViewController *viewController = [storyboard instantiateInitialViewController];
    
    viewController.config = config;
    viewController.userInfo = userInfo;
    viewController.notificationData = notificationData;
    
    return viewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
    [self loadWebView];
}

#pragma mark - Public

- (void)updateNotificationData:(NSDictionary<NSString *, id> *)notificationData {
    _notificationData = notificationData;
    [self reloadInterfaceStartFromBeginning:YES];
}

- (void)reloadInterfaceStartFromBeginning:(BOOL)startFromBeginning {
    if (startFromBeginning) {
        [self loadWebView];
    } else {
        [self.webView reload];
    }
}

#pragma mark - Private

- (void)setupWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.webView];
    NSDictionary<NSString *, UIView *> *views = @{@"webView": self.webView};
    NSArray<NSLayoutConstraint *> *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:views];
    NSArray<NSLayoutConstraint *> *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|" options:0 metrics:nil views:views];
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
}

- (void)loadWebView {
    if (!self.config) {
        NSLog(@"A DASHConfig is required before using DASHViewController");
        NSError *unableToLoadError = [NSError errorWithDomain:@"io.dashapp.dash" code:1 userInfo:@{NSLocalizedFailureReasonErrorKey: @"Unable to load DASH. Please try again later."}];
        [self.delegate dashViewController:self didFailWithError:unableToLoadError];
        return;
    }
    
    NSString *urlString = self.config.useDevelopmentServers ? DASBaseDevelopmentURLString : DASBaseURLString;
    NSURL *url = [NSURL URLWithString:urlString];
    if (url) {
        NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];
        
        NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray array];
        
        //Add default query items
        NSURLQueryItem *applicationQueryItem = [NSURLQueryItem queryItemWithName:DASApplicationQueryName value:self.config.appId];
        [queryItems addObject:applicationQueryItem];
        NSURLQueryItem *platformQueryItem = [NSURLQueryItem queryItemWithName:DASPlatformQueryName value:DASPlatformQueryValue];
        [queryItems addObject:platformQueryItem];
        
        //Add user email if provided
        if (self.userInfo.userEmail) {
            NSURLQueryItem *userEmailQueryItem = [NSURLQueryItem queryItemWithName:DASEmailQueryName value:self.userInfo.userEmail];
            [queryItems addObject:userEmailQueryItem];
        }
        
        //Add push token if provided
        if (self.userInfo.pushTokenString) {
            NSURLQueryItem *pushQueryItem = [NSURLQueryItem queryItemWithName:DASPushQueryName value:self.userInfo.pushTokenString];
            [queryItems addObject:pushQueryItem];
        }
        
        //Add notification data as query parameters if present
        if (self.notificationData) {
            [self.notificationData enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                NSURLQueryItem *notificationQuery = [NSURLQueryItem queryItemWithName:key value:[NSString stringWithFormat:@"%@", obj]];
                [queryItems addObject:notificationQuery];
            }];
        }
        
        urlComponents.queryItems = queryItems;
        NSURL *fullUrl = urlComponents.URL;
        if (fullUrl) {
            NSURLRequest *request = [NSURLRequest requestWithURL:fullUrl];
            [self.webView loadRequest:request];
        }
    }
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.delegate dashViewController:self didFailWithError:error];
}

#pragma mark - WKUIDelegate

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures {
    NSURL *url = navigationAction.request.URL;
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
    
    return nil;
}

@end
