//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"

@interface qcdDemoViewController : UITableViewController

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *companyListImages;
@property (nonatomic, retain) NSMutableArray *productsList;
@property (nonatomic, retain) NSMutableArray *productsListImages;

@property (nonatomic, retain) IBOutlet  ChildViewController * childVC;

@property (nonatomic, retain) DAO *dao;

-(void)httpGetRequest;

@end
