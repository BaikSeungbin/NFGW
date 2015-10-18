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



@end

@implementation NFSRDetailViewController




UIWebView *_webView;






- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // webView
    if(!_webView)
    {
        _webView = [[UIWebView alloc]init];
    }

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

}

#pragma mark block to auotorotate hybrid webview
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


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

