//
//  AppDelegate.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 5..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSString *now_Title;

@property (assign) float screen_scale;

@property BOOL is_Mody;

@property BOOL is_Mody2;

@property int img_Cnt;

@property int arr_cnt;

- (void)initDataBase;
- (NSString *)getDBPath;


-(void)addDataWithName:(NSString *)name;

-(void)removeDataWithNo:(int)no;

-(NSArray *)getRecords;


-(void)makeTable:(NSString *)title;

-(void)addDataWithTableName:(NSString *)title
                       Name:(NSString *)name
                       Date:(NSString *)date
                     BigImg:(NSData *)img1
                   SmallImg:(NSData *)img2
                       Memo:(NSString *)memo;

-(void)modifyDataWithNo:(int)no
              TableName:(NSString *)title
                   Name:(NSString *)name
                 BigImg:(NSData *)img1
               SmallImg:(NSData *)img2
                   Memo:(NSString *)memo;

-(void)removeDataWithTableName:(NSString *)title No:(int)no;

-(NSArray *)getRecotdsWithTableName:(NSString *)title;

-(NSArray *)getImage1WithTableName:(NSString *)title;

-(NSArray *)getImage2WithTableName:(NSString *)title;

-(void)removeTableWithName:(NSString *)title;

extern NSString *kPlantViewNotificationDataKey;

@end
