//
//  PageViewController.m
//
//  Created by Jack Humphries on 3/20/12.
//  Copyright (c) 2012 Jack Humphries. All rights reserved.
//

#import "PageViewController.h"

@implementation PageViewController

-(id)initWithPDFAtPath:(NSString *)path {
    
    NSURL *pdfUrl = [NSURL fileURLWithPath:path];
    PDFDocument = CGPDFDocumentCreateWithURL((__bridge CFURLRef)pdfUrl);
    totalPages = (int)CGPDFDocumentGetNumberOfPages(PDFDocument);
    
    self = [super initWithNibName:nil bundle:nil];
    
//    currentIndex = 10;
    
    return self;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController 
      viewControllerBeforeViewController:(UIViewController *)viewController {
    
    contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    
    currentIndex = [modelArray indexOfObject:[(ContentViewController *)viewController page]];
    
    if (currentIndex == 0) {
        
        return nil;
        
    }
    
    contentViewController.page = [modelArray objectAtIndex:currentIndex - 1];
    
    return contentViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController {
    
    contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
    
    
    currentIndex = [modelArray indexOfObject:[(ContentViewController *)viewController page]];
    
    
    if (currentIndex == totalPages - 1) {
        
        return nil;
    
    }
    
    contentViewController.page = [modelArray objectAtIndex:currentIndex + 1];
        
    return contentViewController;
    
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation {
    
    UIViewController *currentViewController = [thePageViewController.viewControllers objectAtIndex:0];
    NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
    [thePageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
    
    thePageViewController.doubleSided = NO;

    return UIPageViewControllerSpineLocationMin;
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    //modelArray holds the page numbers
    modelArray = [[NSMutableArray alloc] init];
    
    for (int index = 1; index <= totalPages; index++) {
        
        [modelArray addObject:[NSString stringWithFormat:@"%i", index]];
        
    }
    
    thePageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation: UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    thePageViewController.delegate = self;
    thePageViewController.dataSource = self;
    
    thePageViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    contentViewController = [[ContentViewController alloc] initWithPDF:PDFDocument];
//#warning 여기를 바꾸면, 시작 점프 가능
    contentViewController.page = [modelArray objectAtIndex:2];
    
    NSArray *viewControllers = [NSArray arrayWithObject:contentViewController];
    [thePageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:thePageViewController];
    [self.view addSubview:thePageViewController.view];
    thePageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [thePageViewController didMoveToParentViewController:self];
        
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
   
}

-(void)dealloc {
        
    contentViewController = nil;
    modelArray = nil;
    
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    
    contentViewController = nil;
    modelArray = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIImage *img = [UIImage imageNamed:@"stop_Pdf.png"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn addTarget:self action:@selector(action_Btn) forControlEvents:UIControlEventTouchDown];
    
    [btn setImage:img forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(20, 20, 80, 50);
    
    [self.view addSubview:btn];
    
    
//    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [btn2 setImage:img forState:UIControlStateNormal];
//    
//    btn2.frame = CGRectMake(120, 20, 80, 50);
//    
//    
//    [btn2 addTarget:self action:@selector(action_Btn2) forControlEvents:UIControlEventTouchDown];
//    
//    [self.view addSubview:btn2];
    
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchDetected:)];
    
    [self.view addGestureRecognizer:pinchRecognizer];
    
    pinchRecognizer.delegate=self;
    

}

-(void)pinchDetected:(UIPinchGestureRecognizer *)pinchRecognizer

{
    
    CGFloat scale = pinchRecognizer.scale;
    
    self.view.transform = CGAffineTransformScale(self.view.transform, scale, scale);
    
    pinchRecognizer.scale = 1.0;
    
}

-(void)action_Btn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)action_Btn2{
    
//    float screen_scale = [[UIScreen mainScreen] scale];
//    
//    NSString *path;
//    
//    if (screen_scale == 1.0) {
//        path = [[NSBundle mainBundle] pathForResource:@"plant_2" ofType:@"pdf"];
//    }else{
//        path = [[NSBundle mainBundle] pathForResource:@"plant_2" ofType:@"pdf"];
//    }
//    
//    [self initWithPDFAtPath:path];
//    
//    PageViewController *page = [[PageViewController alloc] initWithPDFAtPath:path];
   
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
