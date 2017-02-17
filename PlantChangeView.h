//
//  PlantChangeView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 17..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GPUImage/GPUImage.h>
#import <AVFoundation/AVFoundation.h>

@interface PlantChangeView : UIViewController<UIPopoverControllerDelegate>

@property (strong, nonatomic) NSData *myData;
@property (strong, nonatomic) NSString *str;
@property (strong, nonatomic) NSString *str2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *txtF;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (strong, nonatomic) AVAudioPlayer *player;
- (IBAction)back_Btn:(UIButton *)sender;

@end
