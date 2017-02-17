//
//  PlantReadView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 8..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "PlantReadView.h"
#import "AppDelegate.h"
#import "PlantChangeView.h"

@interface PlantReadView (){
    
    AppDelegate *delegate;
    
    NSMutableArray *myArray;
    
    NSDictionary *my_dic;
    
    UIView *action_view;
    
    UIActivityIndicatorView *myIndi;
    
    NSThread *thread;
    
    UILabel *lbl;
}

@end

@implementation PlantReadView

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
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    myArray = [NSMutableArray array];
//    
//    [myArray removeAllObjects];
//    
//    [myArray setArray:[delegate getRecotdsWithTableName:_table_name]];
    
//    NSLog(@"%lu",(unsigned long)[_dic count]);
    
    _title_Label.text = [_dic objectForKey:@"name"];
    
    _txtV.text = [NSString stringWithFormat:@"%@",
                  [_dic objectForKey:@"memo"]];
    
    _imageView.image = [UIImage imageWithData:[_dic objectForKey:@"img1"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    //키값을 중심으로 데이터 저장. 화면전환시 딕션너리를 모두 넘기는 것이 아니라 no만 넘긴다.
    
    //    my_dic = [[NSDictionary alloc]init];
    //   [myArray setArray:[delegate getRecordWithNo:(int)[_dic objectForKey:@"no"]]];
    
    //    my_dic = [delegate getRecordWithNo:_row_num];
    
    
    //    NSLog(@"no = %d",(int)[_dic objectForKey:@"no"]);
    
    //    NSLog(@"%@",my_dic);
    
    if (delegate.is_Mody == YES) {
        [self indyView];
        [self thread_2];
    }
    
    
}

-(void)thread_2{
    
    myArray = [NSMutableArray array];
    //
       [myArray removeAllObjects];
    //
    //    [myArray setArray:[delegate getRecotdsWithTableName:_table_name]];
    
    [myArray setArray:[delegate getRecotdsWithTableName:_table_name]];
    
    _dic = [myArray objectAtIndex:_row_num];
    
    _title_Label.text = [_dic objectForKey:@"name"];
    
    _txtV.text = [NSString stringWithFormat:@"%@",
                  [_dic objectForKey:@"memo"]];
    
    _imageView.image = [UIImage imageWithData:[_dic objectForKey:@"img1"]];
    
    [self indiStop];
    
}

-(void)indiStop{
    
    [myIndi stopAnimating];
    [lbl removeFromSuperview];
    [myIndi removeFromSuperview];
}

-(void)indyView{
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
     if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
         
         if([[segue identifier] isEqualToString:@"change"]){
         [[segue destinationViewController] setMyData:[_dic objectForKey:@"img1"]];
         [[segue destinationViewController] setStr:[_dic objectForKey:@"name"]];
         [[segue destinationViewController] setStr2:[_dic objectForKey:@"memo"]];
         }else{
             NSDictionary *dic = _dic;
             [[segue destinationViewController] setDic:dic];
             [[segue destinationViewController] setRow_num:_row_num];
             [[segue destinationViewController] setTable_name:_table_name];
         }
         
         
     }else{
         
         if([[segue identifier] isEqualToString:@"change"]){
             [[segue destinationViewController] setMyData:[_dic objectForKey:@"img1"]];
             [[segue destinationViewController] setStr:[_dic objectForKey:@"name"]];
             [[segue destinationViewController] setStr2:[_dic objectForKey:@"memo"]];

         }
         else
         {
             NSDictionary *dic = _dic;
             [[segue destinationViewController] setDic:dic];
             [[segue destinationViewController] setRow_num:_row_num];
             [[segue destinationViewController] setTable_name:_table_name];
         }
         
         
     }
    
    [self sound_btn:@"click1"];
    
    
    
    
}


- (IBAction)back_Btn:(UIButton *)sender {
    [self sound_btn:@"click2"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edit_Btn:(UIButton *)sender {
    [self sound_btn:@"click1"];
}
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
