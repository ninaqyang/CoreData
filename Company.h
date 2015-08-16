//
//  Company.h
//  NavCtrl
//
//  Created by Nina Yang on 8/7/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property (nonatomic, retain) NSString *companyID;

@property (nonatomic, retain) NSString *companyName;
@property (nonatomic, retain) NSString *companyLogo;

@property (nonatomic, retain) NSMutableArray *products;

@property (nonatomic, retain) NSString *stockPrice;

@end
