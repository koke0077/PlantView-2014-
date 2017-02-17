//
//  GameView2.h
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 20..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BugView.h"
#import <AVFoundation/AVFoundation.h>
@interface GameView2 : UIViewController<BugPointDelegate>{
    
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UILabel *gamePoint;
@property (weak, nonatomic) IBOutlet UILabel *gameLife;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVAudioPlayer *player2;
@end
