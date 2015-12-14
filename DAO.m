//
//  DAO.m
//  NavCtrl
//
//  Created by Nina Yang on 8/10/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

@interface DAO ()

@end

@implementation DAO

static DAO *sharedDAO = nil;

+ (DAO *)sharedCenter {
    if (sharedDAO == nil) {
        sharedDAO = [[super allocWithZone:NULL]init];
    }
    return sharedDAO;
}

#pragma mark Core Data Setup

-(void)initModelContext {
    // Creating ObjectModel
    [self setModel:[NSManagedObjectModel mergedModelFromBundles:nil]];
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:[self model]];
    
    // Creating context
    NSString *path = [self archivePath];
    NSURL *storeURL = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    
    if (![psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        [NSException raise:@"open failed" format:@"reason: %@", [error localizedDescription]];
    }
    
    [self setContext:[[NSManagedObjectContext alloc]init]];
    
    // Add an undo manager
    self.context.undoManager = [[NSUndoManager alloc]init];
    
    // Context points to sqlite store
    [[self context] setPersistentStoreCoordinator:psc];
}

-(NSString *)archivePath {
    NSArray *documentsDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentsDirectories objectAtIndex:0];
    return [documentsDirectory stringByAppendingString:@"/store.data"];
}

#pragma mark Data Operations

-(Product *)createProductID:(NSNumber *)ID name:(NSString *)name logo:(NSString *)logo URL:(NSString *)url {
    Product *product = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:[self context]];
    
    [product setProductID:ID];
    [product setProductName:name];
    [product setProductLogo:logo];
    [product setProductURL:url];
    
    [self saveChanges];
    
    return product;
}

-(Company *)createCompanyID:(NSNumber *)ID name:(NSString *)name logo:(NSString *)logo products:(NSSet *)products {
    Company *company = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:[self context]];
    
    [company setCompanyID:ID];
    [company setCompanyName:name];
    [company setCompanyLogo:logo];
    [company setToProduct:products];
    
    [self saveChanges];
    
    return company;
}

-(void)createCompaniesAndProducts {
    Product *iPad = [self createProductID:[NSNumber numberWithInt:1] name:@"iPad" logo:@"ipad.png" URL:@"https://www.apple.com/ipad/"];
    Product *iPodTouch = [self createProductID:[NSNumber numberWithInt:1] name:@"iPod Touch" logo:@"ipodtouch.png" URL:@"https://www.apple.com/ipod-touch/"];
    Product *iPhone = [self createProductID:[NSNumber numberWithInt:1] name:@"iPhone" logo:@"iphone.png" URL:@"https://www.apple.com/iphone/"];
    NSSet *appleProducts = [[NSSet alloc]initWithObjects:iPad, iPodTouch, iPhone, nil];
    NSLog(@"%@", appleProducts);
    
    Product *galaxyS4 = [self createProductID:[NSNumber numberWithInt:2] name:@"Galaxy S4" logo:@"galaxys4.png" URL:@"http://www.samsung.com/global/microsite/galaxys4/"];
    Product *galaxyNote = [self createProductID:[NSNumber numberWithInt:2] name:@"Galaxy Note" logo:@"galaxynote.png" URL:@"http://www.samsung.com/global/microsite/galaxynote/note/index.html?type=find"];
    Product *galaxyTab = [self createProductID:[NSNumber numberWithInt:2] name:@"Galaxy Tab" logo:@"galaxytab.png" URL:@"http://www.samsung.com/global/microsite/galaxytab/10.1/index.html"];
    NSSet *samsungProducts = [[NSSet alloc]initWithObjects:galaxyS4, galaxyNote, galaxyTab, nil];
    
    Product *mi4i = [self createProductID:[NSNumber numberWithInt:3] name:@"Mi 4i" logo:@"mi4i.png" URL:@"http://www.mi.com/en/mi4i/"];
    Product *mi4 = [self createProductID:[NSNumber numberWithInt:3] name:@"Mi 4" logo:@"mi4.jpg" URL:@"http://www.mi.com/en/mi4/"];
    Product *miNote = [self createProductID:[NSNumber numberWithInt:3] name:@"Mi Note" logo:@"minote.jpg" URL:@"http://www.mi.com/en/minote/"];
    NSSet *xiaomiProducts = [[NSSet alloc]initWithObjects:mi4i, mi4, miNote, nil];
    
    Product *nexus5 = [self createProductID:[NSNumber numberWithInt:4] name:@"Nexus 5" logo:@"nexus5.png" URL:@"http://www.google.com/nexus/5/"];
    Product *nexus6 = [self createProductID:[NSNumber numberWithInt:4] name:@"Nexus 6" logo:@"nexus6.png" URL:@"http://www.google.com/nexus/6/"];
    Product *nexus9 = [self createProductID:[NSNumber numberWithInt:4] name:@"Nexus 9" logo:@"nexus9.png" URL:@"http://www.google.com/nexus/9/"];
    NSSet *nexusProducts = [[NSSet alloc]initWithObjects:nexus5, nexus6, nexus9, nil];
    
    Company *apple = [self createCompanyID:[NSNumber numberWithInt:1] name:@"Apple mobile devices" logo:@"apple.png" products:appleProducts];
    Company *samsung = [self createCompanyID:[NSNumber numberWithInt:2] name:@"Samsung mobile devices" logo:@"samsung.png" products:samsungProducts];
    Company *xiaomi = [self createCompanyID:[NSNumber numberWithInt:3] name:@"XiaoMi mobile devices" logo:@"xiaomi.png" products:xiaomiProducts];
    Company *nexus = [self createCompanyID:[NSNumber numberWithInt:4] name:@"Nexus mobile devices" logo:@"nexus.png" products:nexusProducts];
    
    self.arrayOfNSCompanies = [[NSMutableArray alloc]initWithObjects:apple, samsung, xiaomi, nexus, nil];
    
    self.arrayOfNSCompanies[0] = [self changeProductsToArrays:appleProducts];
    self.arrayOfNSCompanies[1] = [self changeProductsToArrays:samsungProducts];
    self.arrayOfNSCompanies[2] = [self changeProductsToArrays:xiaomiProducts];
    self.arrayOfNSCompanies[3] = [self changeProductsToArrays:nexusProducts];
    NSLog(@"%@", self.arrayOfNSCompanies);
}

-(NSArray *)changeProductsToArrays:(NSSet *)set {
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"productName" ascending:YES];
    NSArray *array = [set sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    return array;
}

-(void)deleteProduct:(NSString *)productName {
    editingMode = YES;
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *entity = [[self.model entitiesByName]objectForKey:@"Product"];
    [request setEntity:entity];
    NSError *error = nil;
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"productName = %@", productName];
    [request setPredicate:p];
    
    NSArray *result = [[self context] executeFetchRequest:request error:&error];
    
    for (Product *product in result) {
        [[self context]deleteObject:product];
    }
    
    [self saveChanges];
}

-(void) reloadDataFromContext {
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [[self.model entitiesByName]objectForKey:@"Company"];
    [request setEntity:entity];
    NSError *error = nil;
    
    NSArray *result = [[self context] executeFetchRequest:request error:&error];
    
    if (!result) {
        [NSException raise:@"fetch failed" format:@"reason: %@", [error localizedDescription]];
    }
    
    self.arrayOfNSCompanies = [[NSMutableArray alloc]init];
    
    for(Company *company in result) {
        CompanyNS *companyNS = [[CompanyNS alloc]init];
        companyNS.companyID = company.companyID;
        companyNS.companyName = company.companyName;
        companyNS.companyLogo = company.companyLogo;
        companyNS.toProduct = [[NSMutableArray alloc] init];
        
        NSArray *sortedProds = [self changeProductsToArrays:company.toProduct];
        
        for(Product *product in sortedProds) {
            ProductNS *productNS = [[ProductNS alloc]init];
            productNS.productID = product.productID;
            productNS.productName = product.productName;
            productNS.productLogo = product.productLogo;
            productNS.productURL = product.productURL;
            
            if ([productNS.productID isEqualToNumber:companyNS.companyID]) {
                [companyNS.toProduct addObject:productNS];
            }
        }
        
        [self.arrayOfNSCompanies addObject:companyNS];
    }
}

-(void)saveChanges {
    NSError *error = nil;
    BOOL *successful = [self.context save:&error];
    if (!successful) {
        NSLog(@"Error saving: %@", [error localizedDescription]);
    }
    NSLog(@"Data saved");
}

-(void)loadAllData {
    [self reloadDataFromContext];
}

@end
