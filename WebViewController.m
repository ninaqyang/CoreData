//
//  WebViewController.m
//  NavCtrl
//
//  Created by Nina Yang on 8/5/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "Product.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.url];
    
    [self.webView loadRequest:urlRequest];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(NSURL *)loadRequestFromString:(NSString*)urlString {
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:urlRequest];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
