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

-(id)initWithName:(NSString *)name logo:(NSString *)logo url:(NSString *)url {
    self = [super init];
    if (self) {
        [self setProductName:name];
        [self setProductLogo:logo];
        [self setProductURL:url];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder {
    NSLog(@"encoder called");
    [encoder encodeObject:[self productName] forKey:@"productName"];
    [encoder encodeObject:[self productLogo] forKey:@"productLogo"];
    [encoder encodeObject:[self productURL] forKey:@"productURL"];

}

-(id)initWithCoder:(NSCoder *)decoder {
    NSLog(@"decoder called");
    self = [super init];
    if (self) {
        [self setProductName:[decoder decodeObjectForKey:@"productName"]];
        [self setProductLogo:[decoder decodeObjectForKey:@"productLogo"]];
        [self setProductURL:[decoder decodeObjectForKey:@"productURL"]];
    }
    return self;
}

@end
