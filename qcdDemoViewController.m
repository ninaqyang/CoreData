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

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"Mobile device makers";
    
    self.dao = [DAO sharedCenter];
    self.childVC.dao = [DAO sharedCenter];
    [self.dao setCompany];
    [self.dao setProducts];
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
            
            for (int i = 0; i < [self.dao.arrayOfCompany count]; i++) {
                NSArray *object = [lines[i] componentsSeparatedByString:@","];
                
                NSLog(@"object = %@\n", object);
                
                Company *company = self.dao.arrayOfCompany[i];
                if(object!=nil){
                    company.stockPrice = [NSString stringWithFormat:@"%@", object[0]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.tableView reloadData];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return [self.dao.arrayOfCompany count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"1row=%lu\n", [indexPath row]);
    
    Company * company = [self.dao.arrayOfCompany objectAtIndex:[indexPath row]];
    cell.textLabel.text = company.companyName;
    cell.imageView.image = [UIImage imageNamed:company.companyLogo];
    cell.detailTextLabel.text = company.stockPrice;
    
    NSLog(@"2row=%lu\n", [indexPath row]);
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    if (fromIndexPath != toIndexPath) {
        Company * company = self.dao.arrayOfCompany[fromIndexPath.row];
        [self.dao.arrayOfCompany removeObjectAtIndex:fromIndexPath.row];
        [self.dao.arrayOfCompany insertObject:company atIndex:toIndexPath.row];
        
//        Company * company = self.dao.stockPriceList[fromIndexPath.row];
//        [self.dao.stockPriceList removeObjectAtIndex:fromIndexPath.row];
//        [self.dao.stockPriceList insertObject:stock.stockPrice atIndex:toIndexPath.row];
    }
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.childVC.title = [self.dao.arrayOfCompany[indexPath.row] companyName];
    self.childVC.dao.company = self.dao.arrayOfCompany[indexPath.row];
    
    NSLog(@"1 self.childVC.dao.company.products = %@ \n", self.childVC.dao.company.products);
    
    [self.navigationController pushViewController:self.childVC animated:YES];
    
}


@end
