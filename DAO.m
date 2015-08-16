//
//  DAO.m
//  NavCtrl
//
//  Created by Nina Yang on 8/10/15.
//  Copyright (c) 2015 Aditya Narayan. All rights reserved.
//

#import "DAO.h"

//@class qcdDemoViewController;

@interface DAO ()
//{
//    NSMutableArray *arrayOfCompany;
//    sqlite3 *companiesAndProductsDB;
//    NSString *dbPathString;
//}

@end

@implementation DAO

static DAO *sharedDAO = nil;

+ (DAO *)sharedCenter {
    if (sharedDAO == nil) {
        sharedDAO = [[super allocWithZone:NULL]init];
    }
    return sharedDAO;
}

-(instancetype)init {
    if (self = [super init]) {
        [self copyOpenDB];
        return self;
    }
    else {
        return nil;
    }
}

-(void)copyOpenDB {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    self.documentsDirectory = [paths objectAtIndex:0];
    self.databaseFileName = [self.documentsDirectory stringByAppendingPathComponent:@"Companies and Products"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager fileExistsAtPath:self.databaseFileName];
    
    if (!success) {
        NSString *dbPathString = @"/Users/ninaqy13/Desktop/Companies and Products";
        success = [fileManager copyItemAtPath:dbPathString toPath:self.databaseFileName error:nil];
    }
}

-(void)setCompany {
    sqlite3 *companiesAndProductsDB;
    const char *dbPath = [self.databaseFileName UTF8String];
    sqlite3_stmt *statement;
        
    if (sqlite3_open(dbPath, &companiesAndProductsDB) == SQLITE_OK) {
        NSString *querySQL = @"SELECT * FROM Company";
        const char *query_sql = [querySQL UTF8String];
        self.arrayOfCompany = [[NSMutableArray alloc]init];
        if (sqlite3_prepare(companiesAndProductsDB, query_sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                Company *company = [[Company alloc]init];
                    
                company.companyID = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                company.companyName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                company.companyLogo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                company.products = [[NSMutableArray alloc]init];
                    
                [self.arrayOfCompany addObject:company];
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(companiesAndProductsDB);
    }

    else {
        NSLog(@"Unable to open db");
    }
}

-(void)setProducts {
    sqlite3 *companiesAndProductsDB;
    const char *dbPath = [self.databaseFileName UTF8String];
    sqlite3_stmt *statement;
        
    if (sqlite3_open(dbPath, &companiesAndProductsDB) == SQLITE_OK) {
        NSString *querySQL = @"SELECT * FROM Product";
        const char *query_sql = [querySQL UTF8String];
            
        if (sqlite3_prepare(companiesAndProductsDB, query_sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                Product *eachProduct = [[Product alloc]init];
                
                eachProduct.companyID =  [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 0)];
                eachProduct.productName = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 1)];
                eachProduct.productLogo = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 2)];
                eachProduct.productURL = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, 3)];
                
                for(Company *company in self.arrayOfCompany){
                    if([eachProduct.companyID isEqualToString:company.companyID]){
                        [company.products addObject:eachProduct];
                    }
                }
            }
            sqlite3_finalize(statement);
        }
        
        sqlite3_close(companiesAndProductsDB);
    }
    
    else {
        NSLog(@"Unable to open db");
    }
}

//-(void)deleteProducts {
//    sqlite3 *companiesAndProductsDB;
//    sqlite3_stmt *deleteStmt = nil;
//    
//    if (sqlite3_open([self.databaseFileName UTF8String], &companiesAndProductsDB) == SQLITE_OK) {
//        if (deleteStmt == nil) {
//            const char *sql = "DELETE FROM Product WHERE product = ?";
//            if (sqlite3_prepare(companiesAndProductsDB, sql, -1, &deleteStmt, NULL) == SQLITE_OK) {
//                <#statements#>
//            }
//        }
//    }
//}

@end
