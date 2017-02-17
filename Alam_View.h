//
//  Alam_View.h
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 12..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface Alam_View : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UIScrollView *scroll_View;

+(void)showReminder:(NSString *)text;



@end
