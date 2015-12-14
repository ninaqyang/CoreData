//
//  ProductCell.m
//  NavCtrl
//
//  Created by Nina Yang on 8/20/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

- (id)initWithFrame:(CGRect)frame {
        
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"ProductCell" owner:self options:nil];
    self = (ProductCell *)[nibViews objectAtIndex:0];

    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [[UIColor blackColor]CGColor];
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 3.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)dealloc {
    [_productName release];
    [_productLogo release];
    [super dealloc];
}
@end
