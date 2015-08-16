//
//  Product.m
//  NavCtrl
//
//  Created by Nina Yang on 8/7/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

- (NSString *)description {
    return [NSString stringWithFormat: @"Product Name=%@ Logo=%@", self.productName, self.productLogo];
}

@end
