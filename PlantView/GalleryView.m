//
//  GalleryView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 8..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "GalleryView.h"
#import "AppDelegate.h"
#import "PictureView.h"
#import "PictureView2.h"
#include <dispatch/dispatch.h>


@interface GalleryView (){
    
    AppDelegate *delegate;
    
    CGRect btn_frame;
    
//    NSThread *thread;
    
    UILabel *lbl;
    
    NSMutableArray *myArray;
    
    int obj_cnt;
    
    int obj_dv;
    
    NSDictionary *dic;
    
    UIImage *image;
    
    UIImage *image2;
    
    PictureView *pView;
    
    PictureView2 *pView2;
    
    UIActivityIndicatorView *myIndi;
    
    UIButton *btn[1000];
    
    dispatch_queue_t dQueue1;
    
}

@end

@implementation GalleryView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pView = [[PictureView alloc]initWithNibName:@"PictureView" bundle:nil];
    pView2 = [[PictureView2 alloc]initWithNibName:@"PictureView2" bundle:nil];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
     dQueue1 = dispatch_queue_create("test", NULL);
    
//    [self indyView];
    
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(thread_2) object:nil];
    
    [NSThread detachNewThreadSelector:@selector(thread_2) toTarget:self withObject:nil];
    
//    [thread start];
    
    
}

-(void)indiStop{
//    
//    [myIndi stopAnimating];
//    [lbl removeFromSuperview];
//    [myIndi removeFromSuperview];
}

-(void)indyView{
    
    
//    myIndi = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    myIndi.hidesWhenStopped = YES;
//    
//    myIndi.center = self.view.center;
//    
//    //    self.label.hidden = NO;
//    
//    lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2, 40, 40)];
//    
//    lbl.backgroundColor = [UIColor grayColor];
//    
//    lbl.center = self.view.center;
//    
//    lbl.alpha = 0.5;
//    
//    [self.view addSubview:lbl];
//    
//    [self.view addSubview:myIndi];
//    
//    [myIndi startAnimating];
}


-(void) thread_2{
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        myIndi = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        myIndi.hidesWhenStopped = YES;
        
        myIndi.center = self.view.center;
        
        //    self.label.hidden = NO;
        
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2, 40, 40)];
        
        lbl.backgroundColor = [UIColor grayColor];
        
        lbl.center = self.view.center;
        
        lbl.alpha = 0.5;
        
        [self.view addSubview:lbl];
        
        [self.view addSubview:myIndi];
        
        [myIndi startAnimating];
        
        
        dispatch_async(dQueue1, ^{
            
            myArray = [NSMutableArray array];
            
            [myArray removeAllObjects];
            
            [myArray setArray:[delegate getRecotdsWithTableName:delegate.now_Title]];

            dispatch_async(dispatch_get_main_queue(), ^{
                
                if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                    
                    
                    obj_cnt = (int)[myArray count];
                    
                    //    obj_cnt = delegate.img_Cnt;
                    
                    if (obj_cnt != 0) {
                        
                        //            UIButton *btn[obj_cnt+1];
                        
                        
                        if (obj_cnt%3 == 0) {
                            obj_dv = obj_cnt/3;
                        }else{
                            obj_dv = obj_cnt/3+1;
                        }
                        
                        
                        btn_frame = CGRectMake(20, 70, 80, 100);
                        
                        int a[obj_dv][3];
                        
                        int k=0;
                        
                        int cnt2 = 0;
                        for (int i=0; i<obj_dv ; i++) {
                            
                            for (int j=0; j<3; j++) {
                                a[i][j] = cnt2;
                                
                                cnt2++;
                                
                                if (cnt2 == obj_cnt){
                                    break;
                                }
                            }
                        }
                        int cnt =0;
                        
                        for (int i=0; i<obj_dv; i++) {
                            
                            for (int j=0; j<3; j++) {
                                
                                if (a[i][j] == cnt) {
                                    dic = myArray[cnt];
                                    
                                    btn[cnt] = [[UIButton alloc]initWithFrame:CGRectMake(btn_frame.origin.x+(j*100) , btn_frame.origin.y+(i*120) , 80, 100)];
                                    
                                    btn[cnt].tag = cnt;
                                    
                                    image = [UIImage imageWithData:[dic objectForKey:@"img2"]];
                                    
                                    
                                    
                                    [btn[cnt] setImage:image forState:UIControlStateNormal];
                                    
                                    [btn[cnt] addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
                                    
                                    [self.view setNeedsDisplay];
                                    
                                    [_scrollView addSubview:btn[cnt]];
                                    
                                    if (k<3) {
                                        k++;
                                    }else{
                                        k=0;
                                    }
                                    cnt++;
                                }
                                if (cnt == obj_cnt+1) {
                                    break;
                                }
                            }
                        }
                        
                        
                        _scrollView.scrollEnabled = YES;
                        
                        if (obj_dv > 3) {
                            
                            [_scrollView setContentSize:CGSizeMake(320, btn[obj_cnt-1].frame.origin.y+130)];
                            
                        }else{
                            [_scrollView setContentSize:CGSizeMake(320, 480)];
                        }
                        
                    }
                    
                }else{
                    
                    obj_cnt = (int)[myArray count];
                    
                    //    obj_cnt = delegate.img_Cnt;
                    
                    if (obj_cnt != 0) {
                        
                        //            UIButton *btn[obj_cnt+1];
                        
                        
                        if (obj_cnt%4 == 0) {
                            obj_dv = obj_cnt/4;
                        }else{
                            obj_dv = obj_cnt/4+1;
                        }
                        
                        
                        
                        btn_frame = CGRectMake(-25, -25, 250, 250);
                        
                        int a[obj_dv][4];
                        
                        int k=0;
                        
                        int cnt2 = 0;
                        
//                        NSLog(@"obj dv = %d",obj_dv);
                        for (int i=0; i<obj_dv ; i++) {
                            
                            for (int j=0; j<4; j++) {
                                a[i][j] = cnt2;
                                
                                cnt2++;
                                
                                if (cnt2 == obj_cnt){
                                    break;
                                }
                            }
                            
//                            NSLog(@" i = %d", i);
                        }
                        int cnt =0;
                        
                        for (int i=0; i<obj_dv; i++) {
                            
                            for (int j=0; j<4; j++) {
                                
                                if (a[i][j] == cnt) {
                                    dic = myArray[cnt];
                                    
                                    btn[cnt] = [[UIButton alloc]initWithFrame:CGRectMake(btn_frame.origin.x+(j*150) , btn_frame.origin.y+(i*150) , 250, 250)];
                                    
                                    btn[cnt].tag = cnt;
                                    
                                    image = [UIImage imageWithData:[dic objectForKey:@"img2"]];
                                    
                                    
                                    
                                    [btn[cnt] setImage:image forState:UIControlStateNormal];
                                    
                                    [btn[cnt] addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
                                    
                                    [self.view setNeedsDisplay];
                                    
                                    [_scrollView addSubview:btn[cnt]];
                                    
                                    if (k<4) {
                                        k++;
                                    }else{
                                        k=0;
                                    }
                                    cnt++;
                                }
                                if (cnt == obj_cnt+1) {
                                    break;
                                }
                            }
                        }
                        
                        
                        _scrollView.scrollEnabled = YES;
                        
                        if (obj_dv > 4) {
                            
                            //                [_scrollView setContentSize:CGSizeMake(656, 730+((obj_dv-4)*100)+obj_dv/8*120 + obj_dv/10*80)];
                            [_scrollView setContentSize:CGSizeMake(656, btn[obj_cnt-1].frame.origin.y+200)];
                            
                            
                        }else{
                            [_scrollView setContentSize:CGSizeMake(656, 714)];
                        }
                        
                    }
                    
                }
                
                [myIndi stopAnimating];
                [lbl removeFromSuperview];
                [myIndi removeFromSuperview];
        
        
            });
        });
    
    });
    


}

-(void)viewWillAppear:(BOOL)animated{
    
    if (delegate.is_Mody2 == YES) {
    
        for (int i = 0; i < delegate.arr_cnt; i++) {
            [btn[i] removeFromSuperview];
        }
        
//        [self indyView];
//        
//        NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(thread_2) object:nil];
//        
//        [thread2 start];
        [NSThread detachNewThreadSelector:@selector(thread_2) toTarget:self withObject:nil];
        
        [self.view setNeedsDisplay];
        
        delegate.is_Mody2 =NO;
    }
    
    

}

-(void)viewDidDisappear:(BOOL)animated{
    
    delegate.arr_cnt = obj_cnt;

}

-(void)action_Btn:(UIButton *)sender{
    
    [self sound_btn:@"click1"];
    
   int num = (int)sender.tag;
    
    
//    NSLog(@"tag = %d", num);
//
    dic = myArray[num];
    
    image2 = [UIImage imageWithData:[dic objectForKey:@"img1"]];
    
   
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
         pView2.image = image2;
        
        [self.navigationController pushViewController:pView2 animated:YES];
        
    }else{
        
         pView.image = image2;
        
        pView.view.frame = CGRectMake(0, 0, 768, 974);
        
        [self.navigationController pushViewController:pView animated:YES];
    }
    
    
    
}

-(void)makeBtn:(CGRect *)rect{
    
//    btn = [[UIButton alloc]initWithFrame:btn_frame];
//    
//    btn.backgroundColor = [UIColor redColor];
//    
//    [self.view addSubview:btn];
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

@end



/* thread_2 에 들어갔었던 내용.
 
 //    myArray = [NSMutableArray array];
 //
 //    [myArray removeAllObjects];
 //
 //    [myArray setArray:[delegate getRecotdsWithTableName:delegate.now_Title]];
 //
 //    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
 //
 //
 //        obj_cnt = (int)[myArray count];
 //
 //        //    obj_cnt = delegate.img_Cnt;
 //
 //        if (obj_cnt != 0) {
 //
 ////            UIButton *btn[obj_cnt+1];
 //
 //
 //            if (obj_cnt%3 == 0) {
 //                obj_dv = obj_cnt/3;
 //            }else{
 //                obj_dv = obj_cnt/3+1;
 //            }
 //
 //
 //            btn_frame = CGRectMake(20, 70, 80, 100);
 //
 //            int a[obj_dv][3];
 //
 //            int k=0;
 //
 //            int cnt2 = 0;
 //            for (int i=0; i<obj_dv ; i++) {
 //
 //                for (int j=0; j<3; j++) {
 //                    a[i][j] = cnt2;
 //
 //                    cnt2++;
 //
 //                    if (cnt2 == obj_cnt){
 //                        break;
 //                    }
 //                }
 //            }
 //            int cnt =0;
 //
 //            for (int i=0; i<obj_dv; i++) {
 //
 //                for (int j=0; j<3; j++) {
 //
 //                    if (a[i][j] == cnt) {
 //                        dic = myArray[cnt];
 //
 //                        btn[cnt] = [[UIButton alloc]initWithFrame:CGRectMake(btn_frame.origin.x+(j*100) , btn_frame.origin.y+(i*120) , 80, 100)];
 //
 //                        btn[cnt].tag = cnt;
 //
 //                        image = [UIImage imageWithData:[dic objectForKey:@"img2"]];
 //
 //
 //
 //                        [btn[cnt] setImage:image forState:UIControlStateNormal];
 //
 //                        [btn[cnt] addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
 //
 //                        [self.view setNeedsDisplay];
 //
 //                        [_scrollView addSubview:btn[cnt]];
 //
 //                        if (k<3) {
 //                            k++;
 //                        }else{
 //                            k=0;
 //                        }
 //                        cnt++;
 //                    }
 //                    if (cnt == obj_cnt+1) {
 //                        break;
 //                    }
 //                }
 //            }
 //
 //
 //            _scrollView.scrollEnabled = YES;
 //
 //            if (obj_dv > 3) {
 //
 //                [_scrollView setContentSize:CGSizeMake(320, btn[obj_cnt-1].frame.origin.y+130)];
 //
 //            }else{
 //                [_scrollView setContentSize:CGSizeMake(320, 480)];
 //            }
 //
 //        }
 //
 //    }else{
 //
 //        obj_cnt = (int)[myArray count];
 //
 //        //    obj_cnt = delegate.img_Cnt;
 //
 //        if (obj_cnt != 0) {
 //
 ////            UIButton *btn[obj_cnt+1];
 //
 //
 //            if (obj_cnt%4 == 0) {
 //                obj_dv = obj_cnt/4;
 //            }else{
 //                obj_dv = obj_cnt/4+1;
 //            }
 //
 //
 //
 //            btn_frame = CGRectMake(-25, -25, 250, 250);
 //
 //            int a[obj_dv][4];
 //
 //            int k=0;
 //
 //            int cnt2 = 0;
 //
 //            NSLog(@"obj dv = %d",obj_dv);
 //            for (int i=0; i<obj_dv ; i++) {
 //
 //                for (int j=0; j<4; j++) {
 //                    a[i][j] = cnt2;
 //
 //                    cnt2++;
 //
 //                    if (cnt2 == obj_cnt){
 //                        break;
 //                    }
 //                }
 //
 //                NSLog(@" i = %d", i);
 //            }
 //            int cnt =0;
 //
 //            for (int i=0; i<obj_dv; i++) {
 //
 //                for (int j=0; j<4; j++) {
 //
 //                    if (a[i][j] == cnt) {
 //                        dic = myArray[cnt];
 //
 //                        btn[cnt] = [[UIButton alloc]initWithFrame:CGRectMake(btn_frame.origin.x+(j*150) , btn_frame.origin.y+(i*150) , 250, 250)];
 //
 //                        btn[cnt].tag = cnt;
 //
 //                        image = [UIImage imageWithData:[dic objectForKey:@"img2"]];
 //
 //
 //
 //                        [btn[cnt] setImage:image forState:UIControlStateNormal];
 //
 //                        [btn[cnt] addTarget:self action:@selector(action_Btn:) forControlEvents:UIControlEventTouchUpInside];
 //
 //                        [self.view setNeedsDisplay];
 //
 //                        [_scrollView addSubview:btn[cnt]];
 //
 //                        if (k<4) {
 //                            k++;
 //                        }else{
 //                            k=0;
 //                        }
 //                        cnt++;
 //                    }
 //                    if (cnt == obj_cnt+1) {
 //                        break;
 //                    }
 //                }
 //            }
 //
 //
 //            _scrollView.scrollEnabled = YES;
 //
 //            if (obj_dv > 4) {
 //
 ////                [_scrollView setContentSize:CGSizeMake(656, 730+((obj_dv-4)*100)+obj_dv/8*120 + obj_dv/10*80)];
 //                [_scrollView setContentSize:CGSizeMake(656, btn[obj_cnt-1].frame.origin.y+200)];
 //
 //
 //            }else{
 //                [_scrollView setContentSize:CGSizeMake(656, 714)];
 //            }
 //            
 //        }
 //        
 //    }
 //    
 //    [myIndi stopAnimating];
 //    [lbl removeFromSuperview];
 //    [myIndi removeFromSuperview];
 
 */
