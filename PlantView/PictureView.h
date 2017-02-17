//
//  PictureView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 11..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <GPUImage/GPUImage.h>


@interface PictureView : UIViewController<UIPopoverControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIImage *image;
- (IBAction)back_Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title_lbl;
@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)nextBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *skech_Btn;
@property (weak, nonatomic) IBOutlet UIButton *back_Btn;

@end
