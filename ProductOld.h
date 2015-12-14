//
//  Product.h
//  NavCtrl
//
//  Created by Nina Yang on 8/7/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject <NSCoding>

@property (nonatomic, retain) NSString *companyID;
@property (nonatomic, retain) NSString *productID;

@property (nonatomic, retain) NSString *productName;
@property (nonatomic, retain) NSString *productLogo;
@property (nonatomic, retain) NSString *productURL;

-(id)initWithName:(NSString *)name logo:(NSString *)logo url:(NSString *)url;

@end
