//
//  DAO.h
//  NavCtrl
//
//  Created by Nina Yang on 8/10/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Company.h"
#import "Product.h"

@interface DAO : NSObject <NSURLSessionDataDelegate>

@property (nonatomic, retain) NSMutableArray *stockPriceList;

@property (nonatomic, retain) NSMutableData *responsedata;

// SQL
@property (nonatomic, retain) NSString *documentsDirectory;
@property (nonatomic, retain) NSString *databaseFileName;
@property (nonatomic, retain) NSMutableArray *arrayOfCompany;

@property (nonatomic, retain) Company *company;

+ (DAO *)sharedCenter;
-(instancetype)init;

-(void)copyOpenDB;
-(void)setCompany;
-(void)setProducts;
-(void)deleteProducts;

@end
