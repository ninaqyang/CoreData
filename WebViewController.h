//
//  WebViewController.h
//  NavCtrl
//
//  Created by Nina Yang on 8/5/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController

@property (retain, nonatomic) IBOutlet WKWebView *webView;
@property (retain, nonatomic) NSURL * url;

@end
