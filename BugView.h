//
//  BugView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BugPointDelegate <NSObject>

@required

-(void)bugPoint:(int)point;

@end

@interface BugView : UIViewController

@property (strong, nonatomic) id<BugPointDelegate> bug_delegate;
-(void)change_bug;
@end

