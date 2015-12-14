//
//  CompanyNS.h
//  NavCtrl
//
//  Created by Nina Yang on 8/27/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompanyNS : NSObject

@property (nonatomic, retain) NSString * companyLogo;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSNumber * companyID;
@property (nonatomic, retain) NSMutableArray *toProduct;

@property (nonatomic, retain) NSString * stockPrice;

@end
