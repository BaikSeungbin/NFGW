//
//  UIViewController+NFSRDetailView.m
//  NewsFeed_sugarain
//
//  Created by SBHR on 2015. 10. 3..
//  Copyright © 2015년 seungbin.baik. All rights reserved.
//

#import "NFSRDetailViewController.h"


@interface NFSRDetailViewController () <NSURLConnectionDataDelegate> {
    
}


- (void)configureView;
@end

@implementation NFSRDetailViewController


@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;


UIWebView *_webView;



#pragma mark - Managing the detail item

/*- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

*/



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
   // [self configureView];
    
    
    // webView
    _webView.delegate = self;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webview
{
    if (webview.isLoading)
        return;
    else
        _webView.hidden = false;
}


- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.detailDescriptionLabel = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"상세보기", @"Detail");
    }
    return self;
}
*/


- (void)dealloc {
    [_webView release];
    [super dealloc];
}



#pragma mark alertView attachment file download

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request);
    NSString *requestStr = [[request URL] absoluteString];
    NSRange range;
    range = [requestStr rangeOfString:@"http://gw.plani.co.kr/attachment/files"];
    
    if(range.location !=NSNotFound)
    {
        [[UIApplication sharedApplication] openURL:[request URL]];
        
    }
    
    return YES;
}

@end

