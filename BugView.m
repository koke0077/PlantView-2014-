//
//  BugView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "BugView.h"

@interface BugView (){
    
    UIImage *img1;
    UIImage *img2;
    
    NSTimer *timer;
}
@property (weak, nonatomic) IBOutlet UIImageView *bug_Img;

@end

@implementation BugView
@synthesize bug_delegate;



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    img1 = [UIImage imageNamed:@"bug.png"];
    img2 = [UIImage imageNamed:@"bang.png"];
    
    self.bug_Img.image = img1;
    
    self.view.alpha = 1.0;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.1 target:self selector:@selector(removeBug:) userInfo:nil repeats:NO];
}

-(void) removeBug:(NSTimer *)timer{
    
    [self.view removeFromSuperview];
    
}
-(void)change_bug{
    
    self.bug_Img.image = img2;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    UITouch *touch = [[event allTouches] anyObject];
//    
//    [self.view.superview bringSubviewToFront: touch.view];
//    
//    self.bug_Img.image = img2;
//    
//    [self animation2:self.view];
//    
//    [self.bug_delegate bugPoint:[self returnPoint]];
//    
//    NSLog(@"touch");
//}



-(int) returnPoint{
    
    int a=1;
    
    return a;
    
}
@end
