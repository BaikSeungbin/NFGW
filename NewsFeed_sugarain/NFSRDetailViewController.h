//
//  UIViewController+NFSRDetailView.h
//  NewsFeed_sugarain
//
//  Created by SBHR on 2015. 10. 3..
//  Copyright © 2015년 seungbin.baik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFSRTableViewController.h"



@interface NFSRDetailViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>
{
    
}


@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

