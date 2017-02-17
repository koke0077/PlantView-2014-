//
//  PdfViewrController.m
//  PlantView
//
//  Created by kimsung jun on 2014. 6. 3..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "PdfViewrController.h"
#import "PageViewController.h"

@interface PdfViewrController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *view1;

- (IBAction)pdf_View:(UIButton *)sender;
@end

@implementation PdfViewrController

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
    
    _scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pdf_View:(UIButton *)sender {
    
//    float screen_scale = [[UIScreen mainScreen] scale];
    
    NSString *path;
    
//    if (screen_scale == 1.0) {
//        path = [[NSBundle mainBundle] pathForResource:@"plant1" ofType:@"pdf"];
//    }else{
//        path = [[NSBundle mainBundle] pathForResource:@"plant_2" ofType:@"pdf"];
//    }
//    
     path = [[NSBundle mainBundle] pathForResource:@"plant" ofType:@"pdf"];
    
    
    PageViewController *page = [[PageViewController alloc] initWithPDFAtPath:path];
    
    
    
    [self presentViewController:page animated:YES completion:NULL];
    
//    [self.view addSubview:page.view];
//
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [btn setTitle:@"BTN" forState:UIControlStateNormal];
//    
//    btn.frame = CGRectMake(100, 100, 100, 100);
//    
//    //    [self addChildViewController:btn];
//    [self.view addSubview:btn];
//    [self addChildViewController:btn];
    

    
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _view1;
}

@end
