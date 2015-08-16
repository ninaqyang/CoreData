//
//  ChildViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "DAO.h"
#import "Company.h"
#import "Product.h"

@interface ChildViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *productsImages;

@property (nonatomic, retain) DAO *dao;

@property (nonatomic, retain) WebViewController * webVC;

@end
