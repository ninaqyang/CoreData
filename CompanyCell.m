//
//  NibCellCollectionViewCell.m
//  NavCtrl
//
//  Created by Nina Yang on 8/19/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "CompanyCell.h"

@implementation CompanyCell

- (id)initWithFrame:(CGRect)frame {
   
    // self = [super initWithFrame:frame];

    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"CompanyCell" owner:self options:nil];
    self = (CompanyCell*)[nibViews objectAtIndex:0];
    
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 3.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    return self;
}

- (void)dealloc {
    [_companyName release];
    [_companyImage release];
    [_stockPrice release];
    [super dealloc];
}

@end
