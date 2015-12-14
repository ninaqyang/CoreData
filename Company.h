//
//  Company.h
//  NavCtrl
//
//  Created by Nina Yang on 8/28/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSString * companyLogo;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSNumber * companyID;
@property (nonatomic, retain) NSSet *toProduct;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addToProductObject:(Product *)value;
- (void)removeToProductObject:(Product *)value;
- (void)addToProduct:(NSSet *)values;
- (void)removeToProduct:(NSSet *)values;

@end
