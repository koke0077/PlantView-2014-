//
//  PictureView2.m
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 26..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "PictureView2.h"
#import "AppDelegate.h"

@interface PictureView2 (){
    
    AppDelegate *delegate;
}


@end

@implementation PictureView2

@synthesize image;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    _imageView.image = image;
    _title_Label.text = delegate.now_Title;
}

-(void)viewWillDisappear:(BOOL)animated{
    
    image = nil;
//    _imageView.image = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back_Btn:(UIButton *)sender {
    [self sound_btn:@"click2"];
    [self.navigationController popViewControllerAnimated:YES];
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
