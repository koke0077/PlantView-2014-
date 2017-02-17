//
//  Alam_View.m
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 12..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Alam_View.h"
#import "NSDateUtils.h"
#import "AppDelegate.h"


#define alam_1 @"alam_1"
#define alam_2 @"alam_2"
#define alam_3 @"alam_3"
#define alam_4 @"alam_4"
#define alam_5 @"alam_5"
#define alam_6 @"alam_6"
#define alam_7 @"alam_7"

#define SYSTEM_VERSION_LESS_THAN(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface Alam_View (){
    
    UIImage *img;
    int sun_num;
    int mon_num;
    int tue_num;
    int wed_num;
    int thu_num;
    int fri_num;
    int sat_num;
    
    int select_num;
    
    UILocalNotification *notification_1;
    UILocalNotification *notification_2;
    UILocalNotification *notification_3;
    UILocalNotification *notification_4;
    UILocalNotification *notification_5;
    UILocalNotification *notification_6;
    UILocalNotification *notification_7;
    
    NSUserDefaults *userDefaults;
    
    NSArray *localNotifications;
    
    NSString *reminder1;
    NSString *reminder2;
    NSString *reminder3;
    NSString *reminder4;
    NSString *reminder5;
    NSString *reminder6;
    NSString *reminder7;
    
}
@property (weak, nonatomic) IBOutlet UILabel *mon_alam;
@property (weak, nonatomic) IBOutlet UILabel *sun_alam;
@property (weak, nonatomic) IBOutlet UILabel *tue_alam;
@property (weak, nonatomic) IBOutlet UILabel *wed_alam;
@property (weak, nonatomic) IBOutlet UILabel *thu_alam;
@property (weak, nonatomic) IBOutlet UILabel *fri_alam;
@property (weak, nonatomic) IBOutlet UILabel *sat_alam;
- (IBAction)reSet_Btn:(UIButton *)sender;
- (IBAction)btn_1:(UIButton *)sender;
- (IBAction)btn_2:(UIButton *)sender;
- (IBAction)btn_3:(UIButton *)sender;
- (IBAction)btn_4:(UIButton *)sender;
- (IBAction)btn_5:(UIButton *)sender;
- (IBAction)btn_6:(UIButton *)sender;
- (IBAction)btn_7:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UIImageView *img5;
@property (weak, nonatomic) IBOutlet UIImageView *img6;
@property (weak, nonatomic) IBOutlet UIImageView *img7;

@end

@implementation Alam_View

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    img = [UIImage imageNamed:@"check.png"];
    
   userDefaults = [NSUserDefaults standardUserDefaults];
    
    reminder1 = @"월요일";
    reminder2 = @"화요일";
    reminder3 = @"수요일";
    reminder4 = @"목요일";
    reminder5 = @"금요일";
    reminder6 = @"토요일";
    reminder7 = @"일요일";
    
    localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];

//    NSLog(@"%lu",(unsigned long)[localNotifications count]);
//    NSLog(@"%@",localNotifications);
    
    if ([localNotifications count]>0) {
        sun_num = [userDefaults integerForKey:@"sun"];
        mon_num = [userDefaults integerForKey:@"mon"];
        tue_num = [userDefaults integerForKey:@"tue"];
        wed_num = [userDefaults integerForKey:@"wed"];
        thu_num = [userDefaults integerForKey:@"thu"];
        fri_num = [userDefaults integerForKey:@"fri"];
        sat_num = [userDefaults integerForKey:@"sat"];
        
        if (sun_num !=8) {
            _img1.image = img;
            _sat_alam.text = [NSString stringWithFormat:@"매주 토요일 %d시 %d분",[userDefaults integerForKey:@"sat_Hour"],[userDefaults integerForKey:@"sat_Min"]];
            
        }else{
            _sat_alam.text = @"물주기 알람이 없습니다.";
 
        }
        if (mon_num !=8) {
            _img2.image = img;
            _sun_alam.text = [NSString stringWithFormat:@"매주 일요일 %d시 %d분",[userDefaults integerForKey:@"sun_Hour"],[userDefaults integerForKey:@"sun_Min"]];
        }else{
            _sun_alam.text = @"물주기 알람이 없습니다.";
        }
        if (tue_num !=8) {
            _img3.image = img;
            _mon_alam.text = [NSString stringWithFormat:@"매주 월요일 %d시 %d분",[userDefaults integerForKey:@"mon_Hour"],[userDefaults integerForKey:@"mon_Min"]];
        }else{
            _mon_alam.text = @"물주기 알람이 없습니다.";
        }
        if (wed_num !=8) {
            _img4.image = img;
            _tue_alam.text = [NSString stringWithFormat:@"매주 화요일 %d시 %d분",[userDefaults integerForKey:@"tue_Hour"],[userDefaults integerForKey:@"tue_Min"]];
        }else{
            _tue_alam.text = @"물주기 알람이 없습니다.";
        }
        if (thu_num !=8) {
            _img5.image = img;
            _wed_alam.text = [NSString stringWithFormat:@"매주 수요일 %d시 %d분",[userDefaults integerForKey:@"wed_Hour"],[userDefaults integerForKey:@"wed_Min"]];
        }else{
            _wed_alam.text = @"물주기 알람이 없습니다.";
        }
        if (fri_num !=8) {
            _img6.image = img;
            _thu_alam.text = [NSString stringWithFormat:@"매주 목요일 %d시 %d분",[userDefaults integerForKey:@"thu_Hour"],[userDefaults integerForKey:@"thu_Min"]];
        }else{
            _thu_alam.text = @"물주기 알람이 없습니다.";
        }
        if (sat_num !=8) {
            _img7.image = img;
            _fri_alam.text = [NSString stringWithFormat:@"매주 금요일 %d시 %d분",[userDefaults integerForKey:@"fri_Hour"],[userDefaults integerForKey:@"fri_Min"]];
        }else{
            _fri_alam.text = @"물주기 알람이 없습니다.";
        }
        
        
    }else{
        
        [self re_set];
    }
    
    
    
    
//    NSLog(@"count = %d",[localNotifications count]);
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        
        BOOL is_iPhone_5;
        
        [self.scroll_View setScrollEnabled:YES];
        
        if (CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568))|| CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(568, 320)) == YES) {
            is_iPhone_5 = YES;
        }else{
            is_iPhone_5 = NO;
        }
        
        if (is_iPhone_5) {
            [self.scroll_View setContentSize:CGSizeMake(320, 780)];
        }else{
            self.scroll_View.frame = CGRectMake(0, 50, 320, 650);
            [self.scroll_View setContentSize:CGSizeMake(320, 850)];
        }
        
    }

    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)clearNotification {
	
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)scheduleNotificationDay:(int)day Hour:(int)hour Min:(int)min Info:(NSDictionary *)info{
    
    NSString *str_key;
    
    if (select_num == 1) {
        str_key = @"alam_1";
    }else if (select_num == 2){
        str_key = @"alam_2";
    }else if (select_num == 3){
        str_key = @"alam_3";
    }else if (select_num == 4){
        str_key = @"alam_4";
    }else if (select_num == 5){
        str_key = @"alam_5";
    }else if (select_num == 6){
        str_key = @"alam_6";
    }else if (select_num == 7){
        str_key = @"alam_7";
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];
    NSDateComponents *componentsForFireDate = [calendar components:(NSYearCalendarUnit | NSWeekCalendarUnit|  NSHourCalendarUnit | NSMinuteCalendarUnit| NSSecondCalendarUnit | NSWeekdayCalendarUnit) fromDate: now];
    [componentsForFireDate setWeekday: day] ; //for fixing Sunday
    [componentsForFireDate setHour: hour] ; //for fixing 8PM hour
    [componentsForFireDate setMinute:min] ;
//    [componentsForFireDate setSecond:0] ;
    
    NSDate *fireDateOfNotification = [calendar dateFromComponents: componentsForFireDate];
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    
    notification.userInfo = info;
    
    notification.fireDate = fireDateOfNotification ;
    notification.timeZone = nil;//[NSTimeZone localTimeZone] ;
    notification.alertBody = [NSString stringWithFormat: @"물을 줄 시간이예요!"] ;
    notification.userInfo= [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"New updates added for that week!"] forKey:@"new"];
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.repeatInterval= NSWeekCalendarUnit ;
    notification.soundName=@"start.mp3";
    
    NSData *notiData = [NSKeyedArchiver archivedDataWithRootObject:notification];
    
    [[NSUserDefaults standardUserDefaults] setObject:notiData forKey:str_key];
    
//    NSLog(@"info %@",[notification.userInfo objectForKey:@"alam_1"]);
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notification] ;
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"reloadData" object:self userInfo:info];
    
//    NSLog(@"noti = %@",notification);
}


-(void)re_set{
    
    sun_num = 8;
    mon_num = 8;
    tue_num = 8;
    wed_num = 8;
    thu_num = 8;
    fri_num = 8;
    sat_num = 8;
    
    [userDefaults setInteger:sun_num forKey:@"sun"];
    [userDefaults setInteger:mon_num forKey:@"mon"];
    [userDefaults setInteger:tue_num forKey:@"tue"];
    [userDefaults setInteger:wed_num forKey:@"wed"];
    [userDefaults setInteger:thu_num forKey:@"thu"];
    [userDefaults setInteger:fri_num forKey:@"fri"];
    [userDefaults setInteger:sat_num forKey:@"sat"];
    
    _sun_alam.text = @"알람이 없습니다.";
    _mon_alam.text = @"알람이 없습니다.";
    _tue_alam.text = @"알람이 없습니다.";
    _wed_alam.text = @"알람이 없습니다.";
    _thu_alam.text = @"알람이 없습니다.";
    _fri_alam.text = @"알람이 없습니다.";
    _sat_alam.text = @"알람이 없습니다.";

}
#pragma mark -
#pragma mark === Public Methods ===
#pragma mark -

+(void)showReminder:(NSString *)text {
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reminder"
                                                        message:text delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
	[alertView show];
	
}

- (IBAction)reSet_Btn:(UIButton *)sender {
    
    [self sound_btn:@"click1"];
    
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    
    _img1.image = nil;
    _img2.image = nil;
    _img3.image = nil;
    _img4.image = nil;
    _img5.image = nil;
    _img6.image = nil;
    _img7.image = nil;
    
    [self re_set];
}

- (IBAction)btn_1:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    select_num = 6;
    
    if (sun_num == 8) {
        sun_num = 0;
        
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder6 forKey:alam_6];
        
        [self scheduleNotificationDay:sun_num Hour:[NSDateUtils getHour:[_datePicker date]] Min:[NSDateUtils getMin:[_datePicker date]] Info:userInfo];
        
        [userDefaults setInteger:sun_num forKey:@"sun"];
        
        
//        NSLog(@"%@", [userInfo objectForKey:alam_6]);
        _img1.image = img;
        
        _sat_alam.text = [NSString stringWithFormat:@"매주 토요일 %d시 %d분",[NSDateUtils getHour:[_datePicker date]],[NSDateUtils getMin:[_datePicker date]]];
        
        [userDefaults setInteger:[NSDateUtils getHour:[_datePicker date]] forKey:@"sat_Hour"];
        [userDefaults setInteger:[NSDateUtils getMin:[_datePicker date]] forKey:@"sat_Min"];
        
        
        [userDefaults synchronize];
        
    }else{
        
        sun_num = 8;
        
//        for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
//            NSDictionary *userInfo = notification.userInfo;
//            
//            NSLog(@"alam6 = %@", [userInfo objectForKey:alam_6]);
//            if ([reminder6 isEqualToString:[userInfo objectForKey:alam_6]]){
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//                
//                
//            }
//        }
        
        NSData *dataNoti = [[NSUserDefaults standardUserDefaults] objectForKey:alam_6];
        
        // NSData 타입을 UILocalNotification으로 변환
        // NSKeyedUnarchiver 이용
        UILocalNotification *notif = [NSKeyedUnarchiver unarchiveObjectWithData:dataNoti];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notif];
        
        [userDefaults setInteger:sun_num forKey:@"sun"];
        
        [userDefaults synchronize];
        
        _img1.image = nil;
        
         _sat_alam.text = @"알람이 없습니다.";
        
    }
    
    
}

- (IBAction)btn_2:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    select_num = 7;
    
    if (mon_num == 8) {
        mon_num = 1;
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder7 forKey:alam_7];
        
        [self scheduleNotificationDay:mon_num Hour:[NSDateUtils getHour:[_datePicker date]] Min:[NSDateUtils getMin:[_datePicker date]] Info:userInfo];
        
        [userDefaults setInteger:mon_num forKey:@"mon"];
        
        
        _img2.image = img;
        
        _sun_alam.text = [NSString stringWithFormat:@"매주 일요일 %d시 %d분",[NSDateUtils getHour:[_datePicker date]],[NSDateUtils getMin:[_datePicker date]]];
        
        [userDefaults setInteger:[NSDateUtils getHour:[_datePicker date]] forKey:@"sun_Hour"];
        [userDefaults setInteger:[NSDateUtils getMin:[_datePicker date]] forKey:@"sun_Min"];
        
        
        [userDefaults synchronize];
    }else{
        
        mon_num = 8;
        
//        for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
//            NSDictionary *userInfo = notification.userInfo;
//            if ([reminder7 isEqualToString:[userInfo objectForKey:alam_7]]){
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//        }
        
        NSData *dataNoti = [[NSUserDefaults standardUserDefaults] objectForKey:alam_7];
        
        // NSData 타입을 UILocalNotification으로 변환
        // NSKeyedUnarchiver 이용
        UILocalNotification *notif = [NSKeyedUnarchiver unarchiveObjectWithData:dataNoti];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notif];

        
        [userDefaults setInteger:mon_num forKey:@"mon"];
        
        [userDefaults synchronize];
        
        _img2.image = nil;
        
        _sun_alam.text = @"알람이 없습니다.";
        
    }

}

- (IBAction)btn_3:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    select_num = 1;
    
    if (tue_num == 8) {
        tue_num = 2;
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder1 forKey:alam_1];
        
        [self scheduleNotificationDay:tue_num Hour:[NSDateUtils getHour:[_datePicker date]] Min:[NSDateUtils getMin:[_datePicker date]] Info:userInfo];
        
        [userDefaults setInteger:tue_num forKey:@"tue"];
        
       
        
        _img3.image = img;
        
        _mon_alam.text = [NSString stringWithFormat:@"매주  월요일 %d시 %d분",[NSDateUtils getHour:[_datePicker date]],[NSDateUtils getMin:[_datePicker date]]];
        
        [userDefaults setInteger:[NSDateUtils getHour:[_datePicker date]] forKey:@"mon_Hour"];
        [userDefaults setInteger:[NSDateUtils getMin:[_datePicker date]] forKey:@"mon_Min"];
        
        
        [userDefaults synchronize];
        
    }else{
        
        tue_num = 8;
        
//        for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
//            NSDictionary *userInfo = notification.userInfo;
//            if ([reminder1 isEqualToString:[userInfo objectForKey:alam_1]]){
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//        }

        NSData *dataNoti = [[NSUserDefaults standardUserDefaults] objectForKey:alam_1];
        
        // NSData 타입을 UILocalNotification으로 변환
        // NSKeyedUnarchiver 이용
        UILocalNotification *notif = [NSKeyedUnarchiver unarchiveObjectWithData:dataNoti];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notif];

        
        [userDefaults setInteger:tue_num forKey:@"tue"];
        
        [userDefaults synchronize];
        
        _img3.image = nil;
        
        _mon_alam.text = @"알람이 없습니다.";
        
    }

}

- (IBAction)btn_4:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    select_num = 2;
    
    if (wed_num == 8) {
        wed_num = 3;
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder2 forKey:alam_2];
        
        [self scheduleNotificationDay:wed_num Hour:[NSDateUtils getHour:[_datePicker date]] Min:[NSDateUtils getMin:[_datePicker date]] Info:userInfo];
        
        [userDefaults setInteger:wed_num forKey:@"wed"];
        
        [userDefaults synchronize];
        
        _img4.image = img;
        
        _tue_alam.text = [NSString stringWithFormat:@"매주 화요일 %d시 %d분",[NSDateUtils getHour:[_datePicker date]],[NSDateUtils getMin:[_datePicker date]]];
        
        [userDefaults setInteger:[NSDateUtils getHour:[_datePicker date]] forKey:@"tue_Hour"];
        [userDefaults setInteger:[NSDateUtils getMin:[_datePicker date]] forKey:@"tue_Min"];
        
        
        [userDefaults synchronize];
        
    }else{
        
        wed_num = 8;
        
//        for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
//            NSDictionary *userInfo = notification.userInfo;
//            if ([reminder2 isEqualToString:[userInfo objectForKey:alam_2]]){
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//        }

        NSData *dataNoti = [[NSUserDefaults standardUserDefaults] objectForKey:alam_2];
        
        // NSData 타입을 UILocalNotification으로 변환
        // NSKeyedUnarchiver 이용
        UILocalNotification *notif = [NSKeyedUnarchiver unarchiveObjectWithData:dataNoti];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notif];

        
        [userDefaults setInteger:wed_num forKey:@"wed"];
        
        [userDefaults synchronize];
        
        _img4.image = nil;
        
        _tue_alam.text = @"알람이 없습니다.";
        
    }

}

- (IBAction)btn_5:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    select_num = 3;
    
    if (thu_num == 8) {
        thu_num = 4;
        
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder3 forKey:alam_3];
        
        [self scheduleNotificationDay:thu_num Hour:[NSDateUtils getHour:[_datePicker date]] Min:[NSDateUtils getMin:[_datePicker date]] Info:userInfo];
        
        [userDefaults setInteger:thu_num forKey:@"thu"];
        
        
        
        _img5.image = img;
        
        _wed_alam.text = [NSString stringWithFormat:@"매주 수요일 %d시 %d분",[NSDateUtils getHour:[_datePicker date]],[NSDateUtils getMin:[_datePicker date]]];
        
        [userDefaults setInteger:[NSDateUtils getHour:[_datePicker date]] forKey:@"wed_Hour"];
        [userDefaults setInteger:[NSDateUtils getMin:[_datePicker date]] forKey:@"wed_Min"];
        
        
        [userDefaults synchronize];
        
    }else{
        
        thu_num = 8;
        
//        for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
//            NSDictionary *userInfo = notification.userInfo;
//            if ([reminder3 isEqualToString:[userInfo objectForKey:alam_3]]){
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//        }
        
        NSData *dataNoti = [[NSUserDefaults standardUserDefaults] objectForKey:alam_3];
        
        // NSData 타입을 UILocalNotification으로 변환
        // NSKeyedUnarchiver 이용
        UILocalNotification *notif = [NSKeyedUnarchiver unarchiveObjectWithData:dataNoti];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notif];

        
        [userDefaults setInteger:thu_num forKey:@"thu"];
        
        [userDefaults synchronize];
        
        _img5.image = nil;
        
        _wed_alam.text = @"알람이 없습니다.";
        
    }

}

- (IBAction)btn_6:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    select_num = 4;
    
    if (fri_num == 8) {
        fri_num = 5;
        
       NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder4 forKey:alam_4];
        
        [self scheduleNotificationDay:fri_num Hour:[NSDateUtils getHour:[_datePicker date]] Min:[NSDateUtils getMin:[_datePicker date]] Info:userInfo];
        
        [userDefaults setInteger:fri_num forKey:@"fri"];
        
        
        _img6.image = img;
        
        _thu_alam.text = [NSString stringWithFormat:@"매주 목요일 %d시 %d분",[NSDateUtils getHour:[_datePicker date]],[NSDateUtils getMin:[_datePicker date]]];
        
        [userDefaults setInteger:[NSDateUtils getHour:[_datePicker date]] forKey:@"thu_Hour"];
        [userDefaults setInteger:[NSDateUtils getMin:[_datePicker date]] forKey:@"thu_Min"];
        
        
        [userDefaults synchronize];
        
    }else{
        
        fri_num = 8;
        
//        for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
//            NSDictionary *userInfo = notification.userInfo;
//            if ([reminder4 isEqualToString:[userInfo objectForKey:alam_4]]){
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//        }

        NSData *dataNoti = [[NSUserDefaults standardUserDefaults] objectForKey:alam_4];
        
        // NSData 타입을 UILocalNotification으로 변환
        // NSKeyedUnarchiver 이용
        UILocalNotification *notif = [NSKeyedUnarchiver unarchiveObjectWithData:dataNoti];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notif];

        [userDefaults setInteger:fri_num forKey:@"fri"];
        
        [userDefaults synchronize];
        
        _img6.image = nil;
        
        _thu_alam.text = @"알람이 없습니다.";
        
    }
    
    

}

- (IBAction)btn_7:(UIButton *)sender {
    
    [self sound_btn2:@"pik"];
    
    select_num = 5;
    
    if (sat_num == 8) {
        sat_num = 6;
        
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:reminder5 forKey:alam_5];
        
        [self scheduleNotificationDay:sat_num Hour:[NSDateUtils getHour:[_datePicker date]] Min:[NSDateUtils getMin:[_datePicker date]] Info:userInfo];
        
        [userDefaults setInteger:sat_num forKey:@"sat"];

        
        _img7.image = img;
        
        _fri_alam.text = [NSString stringWithFormat:@"매주 금요일 %d시 %d분",[NSDateUtils getHour:[_datePicker date]],[NSDateUtils getMin:[_datePicker date]]];
        
        [userDefaults setInteger:[NSDateUtils getHour:[_datePicker date]] forKey:@"fri_Hour"];
        [userDefaults setInteger:[NSDateUtils getMin:[_datePicker date]] forKey:@"fri_Min"];
        
        
        [userDefaults synchronize];
        
    }else{
        
        sat_num = 8;
        
//        for (UILocalNotification *notification in [[[UIApplication sharedApplication] scheduledLocalNotifications] copy]){
//            NSDictionary *userInfo = notification.userInfo;
//            if ([reminder5 isEqualToString:[userInfo objectForKey:alam_5]]){
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//            }
//        }

        NSData *dataNoti = [[NSUserDefaults standardUserDefaults] objectForKey:alam_5];
        
        // NSData 타입을 UILocalNotification으로 변환
        // NSKeyedUnarchiver 이용
        UILocalNotification *notif = [NSKeyedUnarchiver unarchiveObjectWithData:dataNoti];
        
        [[UIApplication sharedApplication] cancelLocalNotification:notif];

        [userDefaults setInteger:sat_num forKey:@"sat"];
        
        [userDefaults synchronize];
        
        _img7.image = nil;
        
        _fri_alam.text = @"알람이 없습니다.";
        
    }

}
-(void) sound_btn:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"mp3"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}
-(void) sound_btn2:(NSString *) sound_name{
    
    NSString *str = sound_name;
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:str ofType:@"wav"];
    
    NSURL *url = [NSURL fileURLWithPath:path];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    
    self.player.volume = 0.5;
    
    [self.player prepareToPlay];
    
    [self.player play];
}


@end
