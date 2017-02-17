//
//  PlantReadView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 8..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface PlantReadView : UIViewController

@property (strong, nonatomic) NSDictionary *dic;
@property (strong, nonatomic) NSString *table_name;
@property (nonatomic) NSInteger row_num;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextView *txtV;
@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)back_Btn:(UIButton *)sender;
- (IBAction)edit_Btn:(UIButton *)sender;

@end
