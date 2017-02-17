//
//  TitleSaveView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 5..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>


@interface TitleSaveView : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *title_Txt;

@property (strong,nonatomic) AVAudioPlayer *player;

- (IBAction)save_Btn:(UIButton *)sender;
- (IBAction)cancel_Btn:(UIButton *)sender;
@end
