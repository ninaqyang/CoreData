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
#import "CompanyNS.h"
#import "CompanyCell.h"
#import "ProductNS.h"
#import "ProductCell.h"

@class WebViewController;
@interface ChildViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) NSMutableArray *productsImages;
@property(nonatomic,strong)CompanyNS* chosenCompany;

@property (nonatomic, retain) DAO *dao;

@property (nonatomic, retain) WebViewController * webVC;

@property NSInteger *itemToBeDeleted;
@property (nonatomic, retain) ProductCell *productCell;

- (void)didLongPressCellToDelete:(UILongPressGestureRecognizer *)gesture;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
