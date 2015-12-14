//
//  NibCellCollectionViewCell.h
//  NavCtrl
//
//  Created by Nina Yang on 8/19/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCell : UICollectionViewCell

@property (retain, nonatomic) IBOutlet UILabel *companyName;
@property (retain, nonatomic) IBOutlet UIImageView *companyImage;
@property (retain, nonatomic) IBOutlet UILabel *stockPrice;

@end
