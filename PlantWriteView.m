//
//  PlantWriteView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 6..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "PlantWriteView.h"
#import "AppDelegate.h"
#import "BSKeyboardControls.h"

#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface PlantWriteView (){
    
    AppDelegate *delegate;
    
    UIImage *image;
    
    BOOL is_Txf;
    
    BOOL is_iPhone_5;
    
    CGRect main_View_Frame;
    
    CGRect crop_rect;
    
    int screen_scale;
    
}

@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

@end

@implementation PlantWriteView

@synthesize title_name;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*

- (void)_addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillAnimate:(NSNotification *)notification
{
    
    if (is_Txf == NO) {
        CGRect keyboardBounds;
        [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
        NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
        
        keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        if([notification name] == UIKeyboardWillShowNotification)
        {
            [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - keyboardBounds.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        }
        else if([notification name] == UIKeyboardWillHideNotification)
        {
            [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + keyboardBounds.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        }
        [UIView commitAnimations];
    }
    
}

- (void)_removeKeyboardNotification
{
    if (is_Txf == NO) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    
}

*/

- (void)viewDidLoad
{
    
    screen_scale = [[UIScreen mainScreen] scale];
    _memo.delegate = self;
    _title_Txf.delegate = self;
    
    main_View_Frame = self.view.frame;
    
     [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    image = [UIImage imageNamed:@"anyImg.png"];
    _imageView.image = image;
    
    is_Txf = NO;
    
    delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSArray *fields = @[ self.title_Txf, self.memo];
    
    [self setKeyboardControls:[[BSKeyboardControls alloc] initWithFields:fields]];
    [self.keyboardControls setDelegate:self];
    
    [_scrollView setScrollEnabled:YES];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        
        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))|| CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320)) == YES) {
            is_iPhone_5 = YES;
        }else{
            is_iPhone_5 = NO;
        }
        
        if (is_iPhone_5) {
            [_scrollView setContentSize:CGSizeMake(320, 568)];
        }else{
            [_scrollView setContentSize:CGSizeMake(320, 480)];
            [_scrollView setFrame:CGRectMake(0, 20, 320, 480)];
        }
    }else{
       
        [_scrollView setContentSize:CGSizeMake(758, 1024)];
    }
    
//    NSLog(@"_title_Txf.frame.origin.y = %f", _title_Txf.frame.origin.y);

   
    
    
}
#pragma mark -
#pragma mark Text Field Delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.keyboardControls setActiveField:textField];
}

#pragma mark -
#pragma mark Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //    [_scrollView scrollRectToVisible:_txtV.frame animated:YES];
    
    [self.keyboardControls setActiveField:textView];
    
    
    
}



#pragma mark -
#pragma mark Keyboard Controls Delegate


- (void)keyboardControlsDonePressed:(BSKeyboardControls *)keyboardControls
{
    [self.view endEditing:YES];
}



- (void)_addKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillAnimate:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)keyboardWillAnimate:(NSNotification *)notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardBounds];
    NSNumber *duration = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:[duration doubleValue]];
    [UIView setAnimationCurve:[curve intValue]];
    if([notification name] == UIKeyboardWillShowNotification)
    {
        [self.view setFrame:CGRectMake(main_View_Frame.origin.x, main_View_Frame.origin.y - keyboardBounds.size.height, main_View_Frame.size.width, main_View_Frame.size.height)];
        _scrollView.frame = CGRectMake(0, keyboardBounds.size.height, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            if (is_iPhone_5) {
                [_scrollView setContentSize:CGSizeMake(320, 870)];
            }else{
                [_scrollView setContentSize:CGSizeMake(320, 780)];
                //            [_scrollView setFrame:CGRectMake(0, 20, 320, 480)];
            }
            
        }else{
            
            [_scrollView setContentSize:CGSizeMake(768, 1424)];
        
        }
        
        
        
//        NSLog(@"_title_Txf.frame.origin.y = %f", _title_Txf.frame.origin.y);
        
        
        
        
    }
    else if([notification name] == UIKeyboardWillHideNotification)
    {
        [self.view setFrame:CGRectMake(main_View_Frame.origin.x, main_View_Frame.origin.y, main_View_Frame.size.width, main_View_Frame.size.height)];
        _scrollView.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            
            if (is_iPhone_5) {
                [_scrollView setContentSize:CGSizeMake(320, 568)];
            }else{
                [_scrollView setContentSize:CGSizeMake(320, 480)];
                [_scrollView setFrame:CGRectMake(0, 20, 320, 480)];
            }
            
        }else{
            
            [_scrollView setContentSize:CGSizeMake(758, 1024)];
            
        }
        
        
        
//        NSLog(@"_title_Txf.frame.origin.y = %f", _title_Txf.frame.origin.y);
    }
    [UIView commitAnimations];
    
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//
//    [_txtF resignFirstResponder];
//    [_txtV resignFirstResponder];
//    return YES;
//}


- (void)_removeKeyboardNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}





-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    [self performSelector:@selector(_addKeyboardNotification)];
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:YES];
    
   
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    is_Txf = YES;
    
    return YES;
}



- (void)didReceiveMemoryWarning
{
    
//    [self.cameraController dismissViewControllerAnimated:YES completion:^{}];
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSData *)bigSize:(UIImage *)img{
    
    CGSize bigScale;
    if (screen_scale == 1) {
        bigScale = CGSizeMake(1000, 1000);
    }else{
        bigScale = CGSizeMake(500, 500);
    }
    
    
    UIGraphicsBeginImageContextWithOptions(bigScale, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, bigScale.width, bigScale.height)];
    UIImage *resizeImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(resizeImg);
    
}

-(NSData *)smallSize:(UIImage *)img{
    
    CGSize smallScale;
    if (screen_scale == 1) {
        smallScale = CGSizeMake(100, 100);
    }else{
        smallScale = CGSizeMake(50, 50);
    }
    
    UIGraphicsBeginImageContextWithOptions(smallScale, NO, 0.0);
    [img drawInRect:CGRectMake(0, 0, smallScale.width, smallScale.height)];
    UIImage *reSizeImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImagePNGRepresentation(reSizeImg);
}

-(NSString *)date{
    
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY EEEE MMMM d"];
    [dateFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ko_KR"]];
    
    NSString *dateString = [dateFormat stringFromDate:today];
    
    return dateString;
}

- (IBAction)save_Btn:(UIButton *)sender {
    
    delegate.is_Mody = YES;
    
    delegate.is_Mody2 = YES;
    
    [self sound_btn:@"click1"];
    
    NSString *table_name = delegate.now_Title;
    
    
    NSData *data1 = [self bigSize:image];
    NSData *data2 = [self smallSize:image];
    
    NSString *date = [self date];
    
    NSString *name = _title_Txf.text;
    
    NSString *memo = _memo.text;
    
    [delegate addDataWithTableName:table_name Name:name Date:date BigImg:data1 SmallImg:data2 Memo:memo];
    
    
}

- (IBAction)back_Btn:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)camera_Btn:(UIButton *)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"이미지 가져오기"
                                                            delegate:self cancelButtonTitle:@"취소하기"
                                              destructiveButtonTitle:@"사진찍기"
                                                   otherButtonTitles:@"사진앨범",
                                  nil];
    
    [actionSheet showInView:self.view];

    
}




-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == [actionSheet destructiveButtonIndex]){
        
        self.cameraController = [[UIImagePickerController alloc] init];
        [self.cameraController setDelegate:self];
        [self.cameraController setAllowsEditing:YES];
        [self.cameraController setSourceType:UIImagePickerControllerSourceTypeCamera];
        [self.cameraController setShowsCameraControls:YES];
        [self.cameraController setEditing:NO];
        self.cameraController.modalPresentationStyle = UIModalPresentationCurrentContext;
        
        [self presentViewController:self.cameraController animated:NO completion:nil];
        
    }else if(buttonIndex == [actionSheet firstOtherButtonIndex]){
        
        _cameraController = [[UIImagePickerController alloc]init];
        [_cameraController setDelegate:self];
        [_cameraController setAllowsEditing:YES];
        [_cameraController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        
        [self presentViewController:_cameraController animated:YES completion:nil];
        
    }
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSValue *val =[info objectForKey:UIImagePickerControllerCropRect];
//    NSLog(@"val = %@", val);
    
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    crop_rect = val.CGRectValue;
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], crop_rect);
    
    
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    
    image = cropped;
    
    _imageView.image = image;
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
