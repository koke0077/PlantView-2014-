//
//  FirstViewController.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 5..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "PlantCatalogView.h"
#include <dispatch/dispatch.h>

@interface FirstViewController (){
    
    NSMutableArray *myArray;
    
    NSMutableArray *myArray_2;
    
    AppDelegate *appId;
    
    UIImageView *imageView1;
    UIImageView *imageView2;
    
    dispatch_queue_t dQueue;
  
    

}
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    myArray = [NSMutableArray array];
    
    [myArray removeAllObjects];
    
    appId = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    appId.is_Mody = NO;
    
     dQueue = dispatch_queue_create("test1", NULL);
    
    [NSThread detachNewThreadSelector:@selector(thread1) toTarget:self withObject:nil];
    
//    [myArray setArray:[appId getRecords]];
//    
//    [_tableView reloadData];
    
}

-(void)thread1{
    
    
    dispatch_async(dQueue, ^{
        
        [myArray setArray:[appId getRecords]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_tableView reloadData];
        });
    });
    
    
    
    
}
//-(void)makeTable:(NSString *)char_str{
//    
//    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//    
//    NSString *data_Path = [delegate getDBPath];
//    
//    sqlite3 *database;
//    if (sqlite3_open([data_Path UTF8String], &database) != SQLITE_OK) {
//        sqlite3_close(database);
//        NSLog(@"데이터 베이스 만들기 에러");
//        return;
//    }
//
//    
//    
//    char *sql = (char *)[[NSString stringWithFormat:
//                          @"CREATE TABLE %@ (no INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT)", _char_str] UTF8String];
//    
//    if (sqlite3_exec(database, sql , nil, nil, nil) != SQLITE_OK) {
//        sqlite3_close(database);
//        
//        return;
//    }
//    
//    sqlite3_close(database);
//    
//}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [myArray count];
    
}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
	if (editingStyle == UITableViewCellEditingStyleDelete) {
        
		id AppID = [[UIApplication sharedApplication] delegate];
        
		[AppID removeDataWithNo:[[[myArray objectAtIndex:indexPath.row] objectForKey:@"no"] intValue]];
        [AppID removeTableWithName:[[myArray objectAtIndex:indexPath.row]objectForKey:@"name"]];
        
		[myArray removeObjectAtIndex:indexPath.row];
        
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
        
	}
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel *label;
    
    label = (UILabel *)[cell viewWithTag:1];
    
    label.text = [[myArray objectAtIndex:indexPath.row]objectForKey:@"name"];

    return cell;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
    }else{
        myArray_2 = [[NSMutableArray alloc]init];
        [myArray_2 removeAllObjects];
        
        
        [myArray_2 setArray:[appId getRecotdsWithTableName:[[myArray objectAtIndex:indexPath.row]objectForKey:@"name"]]];
        
        
        
        //    NSDictionary *dic = myArray_2[indexPath.row];
        
//        int countA = [myArray_2 count];
//        NSLog(@"%d", countA);
        
        //    NSLog(@"%@", dic);
        //
        //
        
        
        //    imageView[countA+1];
        
        if (imageView1 != nil) {
            imageView1.image = nil;
        }
        if (imageView2 != nil) {
            imageView2.image = nil;
        }
        
        if ([myArray_2 count] >2) {
            imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 330, 330)];
            imageView1.image = [UIImage imageWithData:[myArray_2[0] objectForKey:@"img1"]];
            imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 390, 330, 330)];
            imageView2.image = [UIImage imageWithData:[myArray_2[1] objectForKey:@"img1"]];
            
            [_view1 addSubview:imageView1];
            [_view1 addSubview:imageView2];
        }else if([myArray_2 count]==1){
            imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 357, 357)];
            imageView1.image = [UIImage imageWithData:[myArray_2[0] objectForKey:@"img1"]];
            
            [_view1 addSubview:imageView1];
            
        }else{
            
        }
        
        
        //    if ([myArray_2 count]>2) {
        //        for (int i =0 ; i < 2; i++) {
        //            imageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*357+20*i, 357, 357)];
        //
        //            imageView[i].image = [UIImage imageWithData:[myArray_2[i] objectForKey:@"img1"]];
        //
        //            [_view1 addSubview:imageView[i]];
        //
        //
        ////            [_scrollView setContentSize:CGSizeMake(357, 357*(i+1))];
        //
        //        }
        //
        //    }else{
        //        for (int i =0 ; i < [myArray_2 count]; i++) {
        //            imageView[i] = [[UIImageView alloc]initWithFrame:CGRectMake(0, i*357+20*i, 357, 357)];
        //
        //            imageView[i].image = [UIImage imageWithData:[myArray_2[i] objectForKey:@"img1"]];
        //
        //            [_view1 addSubview:imageView[i]];
        //        }
        //
        //    }
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
    }else{
        /*
        myArray_2 = [[NSMutableArray alloc]init];
        [myArray_2 removeAllObjects];
        
        
        [myArray_2 setArray:[appId getRecotdsWithTableName:[[myArray objectAtIndex:indexPath.row]objectForKey:@"name"]]];
        
        
        
        if (imageView1 != nil) {
            imageView1.image = nil;
        }
        if (imageView2 != nil) {
            imageView2.image = nil;
        }
        
        if ([myArray_2 count] >2) {
            imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 330, 330)];
            imageView1.image = [UIImage imageWithData:[myArray_2[0] objectForKey:@"img1"]];
            imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 390, 330, 330)];
            imageView2.image = [UIImage imageWithData:[myArray_2[1] objectForKey:@"img1"]];
            
            [_view1 addSubview:imageView1];
            [_view1 addSubview:imageView2];
        }else if([myArray_2 count]==1){
            imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 357, 357)];
            imageView1.image = [UIImage imageWithData:[myArray_2[0] objectForKey:@"img1"]];
            
            [_view1 addSubview:imageView1];
            
        }else{
            
        }
         */
    }
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}



- (IBAction)add_Btn:(UIButton *)sender{
    
    [self sound_btn:@"click1"];
    
}

- (IBAction)edit_Btn:(UIButton *)sender{
    
       [_tableView setEditing:!_tableView.editing animated:YES];
    [self sound_btn:@"click1"];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    
    
    [self sound_btn:@"click1"];
    
    if([[segue identifier] isEqualToString:@"save"]){
    
   
    }else{
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSLog(@"indexPath.row = %ld",(long)indexPath.row);
        NSString *str = [[myArray objectAtIndex:indexPath.row]objectForKey:@"name"];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        delegate.now_Title = str;
        
        
        
    }
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


@end
