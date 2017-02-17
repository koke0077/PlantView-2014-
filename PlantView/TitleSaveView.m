//
//  TitleSaveView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 5..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "TitleSaveView.h"
#import "AppDelegate.h"


@interface TitleSaveView (){
    
    AppDelegate *delegate;
}

@end

@implementation TitleSaveView

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

- (IBAction)save_Btn:(UIButton *)sender {
    
    NSString *str = _title_Txt.text;
    
    [delegate addDataWithName:str];
    
    [delegate makeTable:str];
    
    [self sound_btn:@"click1"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancel_Btn:(UIButton *)sender {
    
     [self sound_btn:@"click1"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
