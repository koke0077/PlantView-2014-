//
//  GameView2.m
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "GameView2.h"

@interface GameView2 (){
    
    
    
    NSTimer *timer1;
    
    NSTimer *timer2;
    
    NSTimer *timer0;
    
    NSTimer *timer4;
    
    UILabel *time_Label;
    
    BugView *bug;
    
    int game_pnt;
    
    UIImage *img2;
    
    UIImageView *bang_view;
    
}

@end

@implementation GameView2



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        time_Label = [[UILabel alloc]initWithFrame:CGRectMake(60, self.view.bounds.size.height/2-100, 200, 200)];
        
    }else{
     
        time_Label = [[UILabel alloc]initWithFrame:CGRectMake(284, 412, 200, 200)];
    }
    
    
    
    [self.view addSubview:time_Label];
    
    time_Label.text = @"3";
    
    time_Label.font = [UIFont systemFontOfSize:100.0];
    
    time_Label.textAlignment = NSTextAlignmentCenter;
    
    self.gameLife.tag = 2;
    
    self.gamePoint.text = @"0";
    
    timer2 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(third_sec:) userInfo:nil repeats:NO];
    
    game_pnt = 0;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
//    NSLog(@"disapear");
    
    [timer invalidate];
    
    [self.player2 stop];
    
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)third_sec:(NSTimer *)timer2{
    
    time_Label.text = @"2";
    
    timer1 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(two_sec:) userInfo:nil repeats:NO];
}

-(void) two_sec:(NSTimer *)timer1{
    
    time_Label.text = @"1";
    
    timer0 = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(first_sec:) userInfo:nil repeats:NO];
    
}

-(void)first_sec:(NSTimer *)timer0{
    
    time_Label.text = @"0";
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(make_Bug:) userInfo:nil repeats:YES];
    
    [self sound_btn3:@"bgm"];
    
}

-(void) make_Bug:(NSTimer *)timer{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        if (self.gameLife.frame.size.width > 1) {
            self.gameLife.frame = CGRectMake(15, 25, self.gameLife.frame.size.width-5, 30);
            
            [time_Label removeFromSuperview];
            
            srandom(time(NULL));
            
            int ran=0;
            
            ran = random()%5+1;
            
            if (ran == 1) {
                
                //        NSLog(@"bug make1");
                
                bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                
                bug.view.tag = 2;
                
                [self.view addSubview:bug.view];
                
                bug.view.frame = CGRectMake(random()%240+40, random()%330+80, 30, 30);
                
                
            }else if(ran == 2){
                
//                NSLog(@"bug make2");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                    bug.view.frame = CGRectMake(random()%240+40, random()%330+80, 30, 30);
                }
                
            }else if(ran == 3){
                
//                NSLog(@"bug make3");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                   bug.view.frame = CGRectMake(random()%240+40, random()%330+80, 30, 30);
                }
                
            }else if(ran == 4){
                
//                NSLog(@"bug make3");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                    bug.view.frame = CGRectMake(random()%240+40, random()%330+80, 30, 30);
                }
                
            }else if(ran == 5){
                
//                NSLog(@"bug make3");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                    bug.view.frame = CGRectMake(random()%240+40, random()%330+80, 30, 30);
                }
                
            }
        }else{
            
            [self timeStop];
        }

        
    }else{
        
        if (self.gameLife.frame.size.width > 1) {
            self.gameLife.frame = CGRectMake(84, 42, self.gameLife.frame.size.width-10, 50);
            
            [time_Label removeFromSuperview];
            
            srandom(time(NULL));
            
            int ran=0;
            
            ran = random()%5+1;
            
            if (ran == 1) {
                
                //        NSLog(@"bug make1");
                
                bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                
                bug.view.tag = 2;
                
                [self.view addSubview:bug.view];
                
                bug.view.frame = CGRectMake(random()%580+100, random()%600+150, 50, 50);
                
                
            }else if(ran == 2){
                
//                NSLog(@"bug make2");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                    bug.view.frame = CGRectMake(random()%580+100, random()%600+150, 50, 50);
                }
                
            }else if(ran == 3){
                
//                NSLog(@"bug make3");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                    bug.view.frame = CGRectMake(random()%580+100, random()%600+150, 50, 50);
                }
                
            }else if(ran == 4){
                
//                NSLog(@"bug make3");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                    bug.view.frame = CGRectMake(random()%580+100, random()%600+150, 50, 50);
                }
                
            }else if(ran == 5){
                
//                NSLog(@"bug make3");
                
                for (int i = 0; i<ran; i++) {
                    
                    bug = [[BugView alloc]initWithNibName:@"BugView" bundle:nil];
                    
                    bug.view.tag = 2;
                    
                    [self.view addSubview:bug.view];
                    
                    bug.view.frame = CGRectMake(random()%580+100, random()%600+150, 50, 50);
                }
                
            }
        }else{
            
            [self timeStop];
        }

    }
    
    
    
}

-(void) timeStop{
    [timer invalidate];
    
    [self.player2 stop];
    
    [self sound_btn2:@"gameover"];
    
    UIImage *point2 = [UIImage imageNamed:@"text_Box.png"];
    
    UIView *ptView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 500, 300)];
    
    ptView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    UIImageView *point_Img = [[UIImageView alloc]initWithImage:point2];
    
    point_Img.frame = CGRectMake(0, 0, 500, 400);
    
    [ptView addSubview:point_Img];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 50, 400, 150)];
    
    [lbl setFont:[UIFont systemFontOfSize:90]];
    
    [lbl setTextAlignment:NSTextAlignmentCenter];
    
    lbl.text = self.gamePoint.text;
    
    [ptView addSubview:lbl];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [btn setBackgroundColor:[UIColor greenColor]];
     
    [[btn titleLabel] setFont:[UIFont boldSystemFontOfSize:40]];
    
    [btn titleLabel].textColor = [UIColor redColor];
    
    [btn setTitle:@"뒤로가기" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(gameSet) forControlEvents:UIControlEventTouchUpInside];
    
    btn.frame = CGRectMake(125, 250, 250, 80);
    
    [ptView addSubview:btn];
    
    [self.view addSubview:ptView];
    
}

-(void) gameSet{
    
    [self sound_btn:@"click1"];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)bugPoint:(int)point{
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
     UITouch  *touch = [[event allTouches] anyObject];
    
    CGPoint point = [touch locationInView:self.view.superview];
    
//    NSLog(@"touch tag = %d",[touch view].tag);
    
    if ([touch view].tag == 2) {
        
        [self sound_btn2:@"bug_die"];
        
        [[touch view] removeFromSuperview];
        
//        NSLog(@"%f, %f",[touch view].frame.origin.x, [touch view].frame.origin.y);
        
        img2 = [UIImage imageNamed:@"bang.png"];

        bang_view = [[UIImageView alloc]initWithImage:img2];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
            
            bang_view.frame = CGRectMake(point.x-30, point.y-30, 60, 60);
            
        }else{
            
            bang_view.frame = CGRectMake(point.x-50, point.y-50, 100, 100);
            
        }
        
        
        
        bang_view.tag = 4;
        
        [self.view addSubview:bang_view];
        
        [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(removeBang:) userInfo:nil repeats:NO];
        
        bang_view.alpha = 1.0;
//
        game_pnt++;
        
        [self bugPoint];
    }
}

-(void)removeBang:(NSTimer *)timer4{
    
     [[self.view viewWithTag:4] removeFromSuperview];
    
    
//    [bang_view removeFromSuperview];
}
-(void)bugPoint{
    
    self.gamePoint.text = [NSString stringWithFormat:@"%d 점",game_pnt*100];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void) sound_btn:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}

-(void) sound_btn2:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}

-(void) sound_btn3:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player2 = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player2.volume = 0.5;
    
    self.player2.numberOfLoops = 5;
    
    [self.player2 prepareToPlay];
    
    [self.player2 play];
}

@end
