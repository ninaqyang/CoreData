//
//  DAO.h
//  NavCtrl
//
//  Created by Nina Yang on 8/10/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import <CoreData/CoreData.h>
#import "Company.h"
#import "Product.h"
#import "CompanyNS.h"
#import "ProductNS.h"

@interface DAO : NSObject <NSURLSessionDataDelegate>
{
    BOOL editingMode;
}

@property (nonatomic, retain) NSMutableArray *stockPriceList;

@property (nonatomic, retain) NSMutableData *responsedata;

@property (nonatomic, retain) NSMutableArray *arrayOfNSCompanies;

@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) Product *product;

@property (nonatomic, retain) CompanyNS *companyNS;
@property (nonatomic, retain) ProductNS *productNS;

+ (DAO *)sharedCenter;

@property(nonatomic, retain) NSManagedObjectContext *context;
@property(nonatomic, retain) NSManagedObjectModel *model;

// Core Data
-(NSString *) archivePath;
-(void)initModelContext;

-(Company *)createCompanyID:(NSNumber *)ID name:(NSString *)name logo:(NSString *)logo products:(NSSet *)products;
-(Product *)createProductID:(NSNumber *)ID name:(NSString *)name logo:(NSString *)logo URL:(NSString *)url;

-(void)createCompaniesAndProducts;
-(NSArray *)changeProductsToArrays:(NSSet *)set;

-(void)deleteProduct:(NSString *)productName;
-(void) reloadDataFromContext;
-(void)loadAllData;

-(void)saveChanges;

@end
