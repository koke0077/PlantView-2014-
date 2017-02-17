//
//  Duryong_WebView.m
//  PlantView
//
//  Created by kimsung jun on 2014. 5. 27..
//  Copyright (c) 2014년 kimsung jun. All rights reserved.
//

#import "Duryong_WebView.h"

@interface Duryong_WebView ()

@end

@implementation Duryong_WebView

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
    
    NSString *str = @"http://www.dooryong.es.kr/modules/cafe/class/index.jsp?SCODE=S0000000090&m_year=2013&m_code=G008003003007004";
	
    self.webView.scalesPageToFit = YES;
    
	NSURL *url = [[NSURL alloc] initWithString:str];
	NSURLRequest *request= [[NSURLRequest alloc] initWithURL:url];
	[_webView loadRequest:request];
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

@end
