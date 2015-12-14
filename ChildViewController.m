//
//  ChildViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ChildViewController.h"

@interface ChildViewController ()

@end

@implementation ChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:240.0f/255.0f blue:241.0f/255.0f alpha:1.0];
    
    [self.collectionView registerClass:[ProductCell class] forCellWithReuseIdentifier:@"cvCell2"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(didLongPressCellToDelete:)];
    longPress.delegate = self;
    [self.collectionView addGestureRecognizer:longPress];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if([NSThread isMainThread])
    NSLog(@"Main Thread");
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - collection view data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chosenCompany.toProduct.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cvCell2";
    ProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ProductNS *product = [self.chosenCompany.toProduct objectAtIndex:indexPath.row];
    cell.productName.text = product.productName;
    cell.productLogo.image = [UIImage imageNamed:product.productLogo];
    
    return cell;
}

- (void)didLongPressCellToDelete:(UILongPressGestureRecognizer *)gesture {
    CGPoint tapLocation = [gesture locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapLocation];
    
    if (indexPath && gesture.state == UIGestureRecognizerStateBegan) {
        NSLog(@"image with index %ld to be deleted", indexPath.item);
        self.itemToBeDeleted = indexPath.item;
        UIAlertView *deleteAlert = [[UIAlertView alloc]initWithTitle:@"Delete?" message:@"Are you sure you want to delete this image?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [deleteAlert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"selected button index = %ld", buttonIndex);
    
    if (buttonIndex == alertView.cancelButtonIndex) {
        NSLog(@"cancel statement clicked");
    }
    else if (buttonIndex == 1) {
        ProductNS *eachProduct = [self.chosenCompany.toProduct objectAtIndex:(long)self.itemToBeDeleted];
        NSLog(@"%@", eachProduct);
        
        [self.dao deleteProduct:eachProduct.productName];
        [self.chosenCompany.toProduct removeObject:eachProduct];

        [self.collectionView reloadData];
    }
}

#pragma mark - collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.webVC = [[WebViewController alloc]initWithNibName:@"WebViewController" bundle:nil];
    
    ProductNS *p = [self.dao.companyNS.toProduct objectAtIndex:indexPath.row];
    NSURL *urlToPush = [NSURL URLWithString:p.productURL];
    self.webVC.url = urlToPush;
    
    [self.navigationController pushViewController:self.webVC animated:YES];
}

@end
