//
//  PlantModyView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 27..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSKeyboardControls.h"
#import <AVFoundation/AVFoundation.h>

@interface PlantModyView : UIViewController<UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate, BSKeyboardControlsDelegate>

@property (nonatomic) NSInteger row_num;

@property (strong, nonatomic) NSMutableDictionary *dic;

@property (strong, nonatomic) NSString *table_name;

@property (strong, nonatomic) AVAudioPlayer *player;

@property (strong, nonatomic) UIImagePickerController *cameraController;

@end
