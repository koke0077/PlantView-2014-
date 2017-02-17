//
//  PlantWriteView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 6..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"
#import <AVFoundation/AVFoundation.h>

@interface PlantWriteView : UIViewController<UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, BSKeyboardControlsDelegate>

@property (strong, nonatomic)NSString *title_name;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *title_Txf;
@property (weak, nonatomic) IBOutlet UITextView *memo;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UIImagePickerController *cameraController;
@property (strong, nonatomic) AVAudioPlayer *player;


- (IBAction)save_Btn:(UIButton *)sender;
- (IBAction)back_Btn:(UIButton *)sender;
- (IBAction)camera_Btn:(UIButton *)sender;

@end
