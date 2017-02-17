//
//  PlantModyView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 27..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "PlantModyView.h"
#import "AppDelegate.h"

#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface PlantModyView (){
    
    AppDelegate *delegate;
    
    NSMutableArray *myArray;
    
    NSDictionary *my_dic;
    
    UIView *action_view;
    
    CGRect main_View_Frame;
    
    CGRect crop_rect;
    
    UIImage *image;
    
    BOOL is_Txf;
    
    BOOL is_iPhone_5;
    
    int screen_scale;
}
@property (weak, nonatomic) IBOutlet UITextField *title_txtF;

@property (nonatomic, strong) BSKeyboardControls *keyboardControls;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UITextView *txt_View;
- (IBAction)back_Btn:(UIButton *)sender;
- (IBAction)save_Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *img_Btn;
- (IBAction)img_Btn:(UIButton *)sender;

@end

@implementation PlantModyView

@synthesize dic, row_num;

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
    
    screen_scale = [[UIScreen mainScreen] scale];
    
     delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    myArray = [NSMutableArray array];
    
    [myArray removeAllObjects];
    
    [myArray setArray:[delegate getRecotdsWithTableName:_table_name]];
    
    _title_txtF.text = [[myArray objectAtIndex:row_num]objectForKey:@"name"];
    
    _txt_View.text = [NSString stringWithFormat:@"%@",
                      [[myArray objectAtIndex:row_num]objectForKey:@"memo"]];
    
    _imageView.image = [UIImage imageWithData:[[myArray objectAtIndex:row_num]objectForKey:@"img1"]];

    _title_txtF.delegate = self;
    _txt_View.delegate = self;
  

    
    is_Txf = NO;
    
    main_View_Frame = self.view.frame;
    
    NSArray *fields = @[ self.txt_View, self.title_txtF];
    
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
                [_scrollView setContentSize:CGSizeMake(320, 750)];
                //            [_scrollView setFrame:CGRectMake(0, 20, 320, 480)];
            }
            
        }else{
            
            [_scrollView setContentSize:CGSizeMake(768, 1424)];
            
        }
        
        
        

        
        
        
        
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

- (IBAction)back_Btn:(UIButton *)sender {
    
    [self sound_btn:@"click2"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save_Btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    UIImage *img = self.imageView.image;
//    NSLog(@"%@",img);
    
    NSData *data1 = [self bigSize:img];
    NSData *data2 = [self smallSize:img];
    
    
    delegate.is_Mody = YES;
    
    delegate.is_Mody2 = YES;
    
//    [delegate modifyDataWithNo:[[dic objectForKey:@"no"] intValue] TableName:_table_name BigImg:data1 SmallImg:data2 Memo:_txt_View.text];
    
    [delegate modifyDataWithNo:[[dic objectForKey:@"no"] intValue] TableName:_table_name Name:self.title_txtF.text BigImg:data1 SmallImg:data2 Memo:_txt_View.text];
    
    
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


- (IBAction)img_Btn:(UIButton *)sender {
    
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
@end
