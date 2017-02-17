//
//  AppDelegate.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 5..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "AppDelegate.h"
#import "Alam_View.h"

#define alam_1 @"alam_1"
#define alam_2 @"alam_2"
#define alam_3 @"alam_3"
#define alam_4 @"alam_4"
#define alam_5 @"alam_5"
#define alam_6 @"alam_6"
#define alam_7 @"alam_7"

@implementation AppDelegate
@synthesize now_Title, img_Cnt, screen_scale, is_Mody, is_Mody2, arr_cnt;

NSString *kPlantViewNotificationDataKey = @"kPlantViewNotificationDataKey";

- (void)initDataBase{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if ([fileManager fileExistsAtPath:data_Path]) {
        return;
    }
    
    sqlite3 *database;
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터 베이스 만들기 에러");
        return;
    }
    
    
    
    char *sql = "CREATE TABLE myTable (no INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT)";
    
    if (sqlite3_exec(database, sql , nil, nil, nil) != SQLITE_OK) {
                        sqlite3_close(database);
        
                        return;
            }
    
        sqlite3_close(database);
    
    

    
}
- (NSString *)getDBPath{
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    return data_Path;
    
}


-(void)addDataWithName:(NSString *)name{
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = "INSERT INTO myTable (name) VALUES(?)";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(void)removeDataWithNo:(int)no{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"디비초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    char *sql = "DELETE FROM myTable WHERE no=?";
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, no);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@" 데이터 삭제 오류");
        }
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
}

-(NSArray *)getRecords{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
    char *sql = "SELECT no, name FROM myTable";
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"no",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"name", nil];
            
            [Result addObject:dic];
        }
    }
    
    return Result;

    
}


-(void)makeTable:(NSString *)title{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"디비초기화 오류");
        return;
    }
    
    
    char *sql = (char *)[[NSString stringWithFormat:
                                                    @"CREATE TABLE IF NOT EXISTS [%@] (no INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, date TEXT, img1 BLUB, img2 BLUB, memo TEXT)", title] UTF8String];
    
    
    
    
    if (sqlite3_exec(database, sql , nil, nil, nil) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"테이블 만들기 오류");
        return;
    }
    
    sqlite3_close(database);
    
}

-(void)addDataWithTableName:(NSString *)title
                       Name:(NSString *)name
                       Date:(NSString *)date
                     BigImg:(NSData *)img1
                   SmallImg:(NSData *)img2
                       Memo:(NSString *)memo{
    
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"INSERT INTO [%@] (name, date, img1, img2, memo) VALUES(?,?,?,?,?)",title]
                         UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"저장에러");
    }else{
        
        sqlite3_bind_text(statement, 1, [name UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 2, [date UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 3, [img1 bytes], (int)[img1 length], SQLITE_TRANSIENT);
        sqlite3_bind_blob(statement, 4, [img2 bytes], (int)[img2 length], SQLITE_TRANSIENT);
        sqlite3_bind_text(statement, 5, [memo UTF8String], -1, SQLITE_TRANSIENT);
        
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@"데이터 저장에러");
        }
    }
    sqlite3_finalize(statement);
    sqlite3_close(database);
}

-(void)modifyDataWithNo:(int)no
                   TableName:(NSString *)title
                  Name:(NSString *)name
                 BigImg:(NSData *)img1
               SmallImg:(NSData *)img2
                   Memo:(NSString *)memo{
    
    
    sqlite3 *database;
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"데이터베이스 초기화 오류");
        return;
    }
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"UPDATE [%@] SET memo=?, img1=?, img2=?, name=? WHERE no=?",title] UTF8String];

    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) != SQLITE_OK) {
        NSLog(@"데이터 업데이트 오류");
    }else{
        
        sqlite3_bind_text(statement, 1, [memo UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_blob(statement, 2, [img1 bytes], (int)[img1 length], SQLITE_TRANSIENT);
        
        sqlite3_bind_blob(statement, 3, [img2 bytes], (int)[img2 length], SQLITE_TRANSIENT);
        
        sqlite3_bind_text(statement, 4, [name UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_int(statement, 5, no);
        
        if (sqlite3_step(statement) !=SQLITE_DONE) {
            NSLog(@"수정오류");
        }
        
        
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
}

-(void)removeDataWithTableName:(NSString *)title No:(int)no{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"디비초기화 오류");
        return;
    }
    
    
    
    sqlite3_stmt *statement;
    char *sql = (char *)[[NSString stringWithFormat:
                          @"DELETE FROM [%@] WHERE no=?",title] UTF8String];
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        sqlite3_bind_int(statement, 1, no);
        if (sqlite3_step(statement) != SQLITE_DONE) {
            NSLog(@" 데이터 삭제 오류");
        }
    }
    
    sqlite3_finalize(statement);
    sqlite3_close(database);

    
}

-(NSArray *)getRecotdsWithTableName:(NSString *)title{
 
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"SELECT no, name, date, img1, img2, memo FROM [%@]",title] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:sqlite3_column_int(statement, 0)],@"no",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)],@"name",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)],@"date",
                                 [NSData dataWithBytes:sqlite3_column_blob(statement, 3) length:sqlite3_column_bytes(statement, 3)],@"img1",
                                 [NSData dataWithBytes:sqlite3_column_blob(statement, 4) length:sqlite3_column_bytes(statement, 4)],@"img2",
                                 [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)],@"memo",
                                 nil];
            
            [Result addObject:dic];
        }
    }
    
  
    
    return Result;
    
}

-(NSArray *)getImage1WithTableName:(NSString *)title{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
    
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"SELECT  img1 memo FROM [%@]",title] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSData dataWithBytes:sqlite3_column_blob(statement, 0) length:sqlite3_column_bytes(statement, 3)],@"img1",
                                 nil];
            
            [Result addObject:dic];
        }
    }
    
    
    
    return Result;
}


-(NSArray *)getImage2WithTableName:(NSString *)title{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    if (sqlite3_open([data_Path UTF8String], &database)) {
        sqlite3_close(database);
        NSLog(@"초기화 오류");
        return nil;
    }
 
    NSMutableArray *Result = [NSMutableArray array];
    
    sqlite3_stmt *statement;
    
    char *sql = (char *)[[NSString stringWithFormat:
                          @"SELECT img2 FROM [%@]",title] UTF8String];
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK) {
        
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 
                                 [NSData dataWithBytes:sqlite3_column_blob(statement, 4) length:sqlite3_column_bytes(statement, 4)],@"img2",
                                 
                                 nil];
            
            [Result addObject:dic];
        }
    }
    
    
    
    return Result;
}


-(void)removeTableWithName:(NSString *)title{
    
    sqlite3 *database;
    
    NSString *data_document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *data_Path = [data_document stringByAppendingPathComponent:@"data.db3"];
    
    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"디비초기화 오류");
        return;
    }
    
    
    char *sql = (char *)[[NSString stringWithFormat:@"DROP TABLE [%@]", title] UTF8String];
    
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(database, sql , -1, &statement, NULL) == SQLITE_OK){
//     NSLog(@"테이블 삭제 에러");
    }
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    sqlite3_close(database);
    
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    screen_scale = [[UIScreen mainScreen] scale];
    
//    NSLog(@"screen_scale = %f",screen_scale);
    
    [self initDataBase];
    
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
   
    if (locationNotification) {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;
        
        
    }

    
//    NSLog(@"%@",locationNotification);

    
//    Class cls = NSClassFromString(@"UILocalNotification");
//	if (cls) {
//		UILocalNotification *notification = [launchOptions objectForKey:
//                                             UIApplicationLaunchOptionsLocalNotificationKey];
//		
//		if (notification) {
//			NSString *reminderText = [notification.userInfo
//									  objectForKey:kPlantViewNotificationDataKey];
//			[Alam_View showReminder:reminderText];
//		}
//	}
//	
//	application.applicationIconBadgeNumber = 0;
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Request to reload table view data
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}


@end
