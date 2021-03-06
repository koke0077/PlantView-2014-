//
//  PlantChangeView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 17..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "PlantChangeView.h"

@interface PlantChangeView (){
    
    UIImage *collageImage;
}
@property (weak, nonatomic) IBOutlet UIButton *out_Btn;
@property (weak, nonatomic) IBOutlet UIButton *back_Btn;

@property (retain, readwrite) UIPopoverController *popover;
- (IBAction)out_Btn:(UIButton *)sender;

@end

@implementation PlantChangeView

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
    
    GPUImageFilter *sketch_filter;
    
    sketch_filter = [[GPUImageSketchFilter alloc]init];
    
    
    
    UIImage *img = [UIImage imageWithData:self.myData];
    
    
    
    UIImage *filterImg = [sketch_filter imageByFilteringImage:img];
    
    
    
    [self.imageView setImage:filterImg];
    
   
    
    self.title_Label.text = self.str;
    self.txtF.text = self.str2;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) makeImg{
    
    
//    NSLog(@"makeImg");
    
    
    CGSize size = self.view.bounds.size;
    
    CGFloat scale = 1.0f;
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        
        scale = [[UIScreen mainScreen] scale];
        
        size = CGSizeApplyAffineTransform(size, CGAffineTransformMakeScale(scale, scale));
        
    }
    
    
    
    UIGraphicsBeginImageContext(size);
    
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(context, scale, scale);
    
    
    
    [self.view.layer renderInContext:context];
    
    collageImage = UIGraphicsGetImageFromCurrentImageContext();
	
    //	UIImageWriteToSavedPhotosAlbum(collageImage,nil,nil,nil);
    
    
    NSString * imagePath = [self getDocumentImagePath]; //getDocumentImagePath를 호출해서 image가 있는 경로를 받는다
    NSString * filename = [self saveFileName]; //이미지명을 생성하는 메소드를 호출
    NSString *savePath = [imagePath stringByAppendingPathComponent:filename];
    NSURL *saveURL = [NSURL fileURLWithPath:savePath];
    //    [imageData writeToURL:saveURL atomically:NO];
    
    NSLog(@"이름%@ %@",filename,saveURL);
    UIGraphicsEndImageContext();
    

}


-(NSString *)getDocumentImagePath
{
    //내 어플의 홈 디렉토리 구하기
    NSString * homeDir = NSHomeDirectory();
    //홈디렉토리/Docu..
    NSString * imagePath = [NSString stringWithFormat:@"%@/Documents",homeDir];
    
    return imagePath;
}

-(NSString *)saveFileName
{
    //새로운 이미지 화일명 생성
    NSDate * now = [NSDate date];
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"YYYYMMddHHmmss"];
    NSString * dateStr = [fmt stringFromDate:now];
    
    
    
    
    NSArray *anyPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strPathBackground = [NSString stringWithFormat:@"%@/plant.jpg",[anyPath objectAtIndex:0]];
    NSData *imageData = [NSData dataWithData:UIImageJPEGRepresentation(collageImage, 120)];
    
    [imageData writeToFile:strPathBackground atomically:YES];
    NSString * savefilename = [NSString stringWithFormat:@"%@.jpg",dateStr];
    
    
    
    return savefilename;
}




- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error != NULL) {
		// Show error message...
		NSLog(@"save error");
    } else {
		NSLog(@"save success");
	}
    
    //	[self.imgView setImage:image];
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

- (IBAction)back_Btn:(UIButton *)sender {
    [self sound_btn:@"click2"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)out_Btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    _back_Btn.hidden = YES;
    _out_Btn.hidden = YES;
    
    [self makeImg];
    
    _back_Btn.hidden = NO;
    _out_Btn.hidden = NO;
    
    NSArray *aryPath1=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *strPathBackgrond1=[NSString stringWithFormat:@"%@/plant.jpg",[aryPath1 objectAtIndex:0]];
    
   UIImage *images = [[UIImage alloc]initWithContentsOfFile:strPathBackgrond1];
    
    
    NSArray* actItems = [NSArray arrayWithObjects:images, nil];
    
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:actItems applicationActivities:nil];
   
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        
        [self presentViewController:activityView animated:YES completion:^{
            
        }];
        
    }else{
        
        self.popover = [[UIPopoverController alloc] initWithContentViewController:activityView];
        if (self.view.frame.size.width > self.view.frame.size.height) {
            [self.popover presentPopoverFromRect:CGRectMake(self.view.frame.size.width, 100, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }else{
            [self.popover presentPopoverFromRect:CGRectMake(self.view.frame.size.width-200, -15, 100, 100) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
        }
        
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

@end
