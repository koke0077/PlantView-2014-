//
//  FirstViewController.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 5..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <AVFoundation/AVFoundation.h>

@interface FirstViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *char_str;

@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)add_Btn:(UIButton *)sender;

- (IBAction)edit_Btn:(UIButton *)sender;








@end
