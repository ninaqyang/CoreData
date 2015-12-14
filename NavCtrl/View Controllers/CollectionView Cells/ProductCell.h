//
//  ProductCell.h
//  NavCtrl
//
//  Created by Nina Yang on 8/20/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UILabel *productName;
@property (retain, nonatomic) IBOutlet UIImageView *productLogo;

@end
