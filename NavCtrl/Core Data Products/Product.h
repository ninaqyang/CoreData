//
//  Product.h
//  NavCtrl
//
//  Created by Nina Yang on 8/28/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * productLogo;
@property (nonatomic, retain) NSString * productName;
@property (nonatomic, retain) NSString * productURL;
@property (nonatomic, retain) NSNumber * productID;

@end
