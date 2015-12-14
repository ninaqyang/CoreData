//
//  qcdDemoViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "qcdDemoViewController.h"

@interface qcdDemoViewController ()

@end

@implementation qcdDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor colorWithRed:236.0f/255.0f green:240.0f/255.0f blue:241.0f/255.0f alpha:1.0];
    self.title = @"Mobile Device Companies";
    
    self.childVC = [[ChildViewController alloc]initWithNibName:@"ChildViewController" bundle:nil];
    [self.collectionView registerClass:[CompanyCell class] forCellWithReuseIdentifier:@"cvCell"];
        
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setItemSize:CGSizeMake(200, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    [self.collectionView setCollectionViewLayout:flowLayout];
    
    self.dao = [DAO sharedCenter];
    self.childVC.dao = [DAO sharedCenter];
    
    [self.dao initModelContext];
    
    [self.dao loadAllData];
    
    if(self.dao.arrayOfNSCompanies.count == 0){
       [self.dao createCompaniesAndProducts];
        [self.dao loadAllData];
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [self httpGetRequest];
}

-(void)httpGetRequest {
    NSURL *url = [NSURL URLWithString:@"http://finance.yahoo.com/d/quotes.csv?s=AAPL+SSNLF+BABA+GOOG&f=a"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    [request setHTTPMethod: @"GET"];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
        if (httpResp.statusCode == 200) {
            
            NSString* respData = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSArray *lines = [respData componentsSeparatedByString:@"\n"];
            
            NSLog(@"lines = %@\n", lines);
            
            for (int i = 0; i < [lines count]-1; i++) {
                NSArray *object = [lines[i] componentsSeparatedByString:@","];
                
                NSLog(@"object = %@\n", object);
                
                CompanyNS *company = self.dao.arrayOfNSCompanies[i];
                if(object!=nil){
                    company.stockPrice = [NSString stringWithFormat:@"%@", object[0]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.collectionView reloadData];
                    });
                }
            }
            
            NSLog(@"respdata = %@\n", respData);
        } else if (error != nil) {
            NSLog(@"%@", error);
        }
    }];
    
    [dataTask resume];
    
}

#pragma mark - collection view data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dao.arrayOfNSCompanies count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cvCell";
    CompanyCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSLog(@"%@", self.dao.arrayOfNSCompanies);
    
    CompanyNS *company = [self.dao.arrayOfNSCompanies objectAtIndex:indexPath.row];
    cell.companyName.text = company.companyName;
    cell.companyImage.image = [UIImage imageNamed:company.companyLogo];
    cell.stockPrice.text = company.stockPrice;

    return cell;
}

#pragma mark - collection view delegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 
    self.childVC.title = [self.dao.arrayOfNSCompanies[indexPath.row] companyName];
    self.childVC.chosenCompany = self.dao.arrayOfNSCompanies[indexPath.row];
    
    self.childVC.products = [[NSMutableArray alloc] initWithArray:self.childVC.dao.companyNS.toProduct];
    NSLog(@"products = %@", self.childVC.products);
    [self.navigationController pushViewController:self.childVC animated:YES];
}

- (void)dealloc {
    [UICollectionView release];
    [super dealloc];
}
@end
