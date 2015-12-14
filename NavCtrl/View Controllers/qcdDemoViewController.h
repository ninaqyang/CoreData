//
//  qcdDemoViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildViewController.h"
#import "CompanyNS.h"
#import "ProductNS.h"
#import "DAO.h"
#import "CompanyCell.h"

@interface qcdDemoViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *companyListImages;
@property (nonatomic, retain) NSMutableArray *productsList;
@property (nonatomic, retain) NSMutableArray *productsListImages;

@property (nonatomic, retain) IBOutlet  ChildViewController * childVC;

@property (nonatomic, retain) DAO *dao;

@property (nonatomic, retain) CompanyCell *companyCell;

@property (nonatomic, retain) NSArray *dataArray;

-(void)httpGetRequest;

@end
