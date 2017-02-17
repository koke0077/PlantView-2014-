//
//  PlantCatalogView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 6..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "PlantCatalogView.h"
#import "AppDelegate.h"
#import "PlantWriteView.h"
#import "PlantReadView.h"
#include <dispatch/dispatch.h>


@interface PlantCatalogView (){
    
    NSMutableArray *myArray;
    
    AppDelegate *delegate;
    
    UIActivityIndicatorView *myIndi;
    
    NSThread *thread;
    
    UILabel *lbl;
    dispatch_queue_t dQueue;
}
@property (weak, nonatomic) IBOutlet UIButton *edit_Btn;

@end

@implementation PlantCatalogView

@synthesize table_name;

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
    
    [self.navigationController setNavigationBarHidden:YES];
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    table_name = delegate.now_Title;
    
    _title_Label.text = table_name;
    
    myArray = [NSMutableArray array];
    
    [myArray removeAllObjects];
    
    UIImage *img = [UIImage imageNamed:@"edit_Btn.png"];
    
    [_edit_Btn setImage:img forState:UIControlStateNormal];
    
//    NSLog(@"PlantCatalog");
    
//    [self indyView];
    
    dQueue = dispatch_queue_create("test", NULL);
    
    [NSThread detachNewThreadSelector:@selector(thread_2) toTarget:self withObject:nil];
    
//    thread = [[NSThread alloc]initWithTarget:self selector:@selector(thread_2) object:nil];
    
//    [thread start];
    
   
}

-(void)thread_2{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        myIndi = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        myIndi.hidesWhenStopped = YES;
        
        myIndi.center = self.view.center;
        

        
        lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-20, self.view.frame.size.height/2, 40, 40)];
        
        lbl.backgroundColor = [UIColor grayColor];
        
        lbl.center = self.view.center;
        
        lbl.alpha = 0.5;
        
        [self.view addSubview:lbl];
        
        [self.view addSubview:myIndi];
        
        [myIndi startAnimating];
        
        id __weak selfweak = self;
        
        dispatch_async(dQueue, ^{
            [myArray setArray:[delegate getRecotdsWithTableName:table_name]];
            
            id __strong selfStrong = selfweak;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (selfStrong) {
                    [[selfStrong tableView] reloadData];
                    [myIndi stopAnimating];
                    [lbl removeFromSuperview];
                    [myIndi removeFromSuperview];
                }
                
                
            });
        });
        
    });
    
//     [myArray setArray:[delegate getRecotdsWithTableName:table_name]];
//      [_tableView reloadData];
//    [self indiStop];
    
}

-(void)indiStop{
    
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

-(void)viewWillAppear:(BOOL)animated{
    
    if (delegate.is_Mody == YES) {
        
        
        myArray = [NSMutableArray array];
        
        [myArray removeAllObjects];
        
        [self indyView];
        
        thread = [[NSThread alloc]initWithTarget:self selector:@selector(thread_2) object:nil];
        
        [thread start];
        
//        [myArray setArray:[delegate getRecotdsWithTableName:table_name]];
    }
    
    delegate.is_Mody = NO;
    
    [_tableView reloadData];
    
//    NSLog(@"%d",[myArray count]);
    
  
    
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
         delegate.is_Mody2 = YES;
        
		id AppID = [[UIApplication sharedApplication] delegate];
        
        [AppID removeDataWithTableName:table_name No:[[[myArray objectAtIndex:indexPath.row] objectForKey:@"no"] intValue]];
//		[AppID removeDataWithNo:[[[myArray objectAtIndex:indexPath.row] objectForKey:@"no"] intValue]];
        
		[myArray removeObjectAtIndex:indexPath.row];
        
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        delegate.img_Cnt = (int)[myArray count];
        
       
      
        
	}
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [myArray count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIImageView *imgView;
    
    imgView = (UIImageView *)[cell viewWithTag:1];
    
    UILabel *label1;
    
    label1 = (UILabel *)[cell viewWithTag:2];
    
    UILabel *label2;
    
    label2 = (UILabel *)[cell viewWithTag:3];
    
    NSDictionary *dic = myArray[indexPath.row];
    
    imgView.image = [UIImage imageWithData:[dic objectForKey:@"img2"]];
    
    label1.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"name"];
    label2.text = [NSString stringWithFormat:@"%@일",
                   [[myArray objectAtIndex:indexPath.row]objectForKey:@"date"]];
    
    
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self sound_btn:@"click1"];
    
    if([[segue identifier] isEqualToString:@"add"]){
        
         [[segue destinationViewController] setTitle_name:table_name];
        
    }else if([[segue identifier] isEqualToString:@"next"]){
        //세그웨이에서 테이블뷰 선택된 셀의 번호 가져오기
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSLog(@"(long)indexPath.row = %ld",(long)indexPath.row);
        NSDictionary *dic = myArray[indexPath.row];
        [[segue destinationViewController] setDic:dic];
        //        [[segue destinationViewController] setMyArray:myArray];
        [[segue destinationViewController] setRow_num:indexPath.row];
        [[segue destinationViewController] setTable_name:table_name];
        
    }
}


- (IBAction)back_Btn:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)edit_Btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    if (!_tableView.editing) {
        [_tableView setEditing:!_tableView.editing animated:YES];
        
        UIImage *img = [UIImage imageNamed:@"done_Btn.png"];
        
        [_edit_Btn setImage:img forState:UIControlStateNormal];
        
        _edit_Btn.frame = CGRectMake(63, 191, 82, 39);
    }else{
        
         [_tableView setEditing:!_tableView.editing animated:YES];
        
        UIImage *img = [UIImage imageNamed:@"edit_Btn.png"];
        
        [_edit_Btn setImage:img forState:UIControlStateNormal];
        
        _edit_Btn.frame = CGRectMake(56, 187, 98, 47);
    }
}



- (IBAction)add_Btn:(UIButton *)sender {
    
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
