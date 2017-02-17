//
//  GalleryView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 8..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GalleryView : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) AVAudioPlayer *player;

@end
