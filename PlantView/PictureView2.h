//
//  PictureView2.h
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 26..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PictureView2 : UIViewController


@property (strong, nonatomic) UIImage *image;
- (IBAction)back_Btn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title_lbl;
@property (strong, nonatomic) AVAudioPlayer *player;
@end
