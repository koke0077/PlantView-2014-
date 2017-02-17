//
//  PlantCatalogView.h
//  PlantView
//
//  Created by kimsung jun on 2014. 4. 6..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import <AVFoundation/AVFoundation.h>

@interface PlantCatalogView : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (copy, nonatomic) NSString *table_name;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *title_Label;
@property (strong, nonatomic) AVAudioPlayer *player;

- (IBAction)back_Btn:(UIButton *)sender;

- (IBAction)edit_Btn:(UIButton *)sender;

- (IBAction)add_Btn:(UIButton *)sender;

@end
