//
//  UIViewController+NFSRLoginViewController.h
//  NewsFeed_sugarain
//
//  Created by SBHR on 2015. 10. 3..
//  Copyright © 2015년 seungbin.baik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIAuthenticationDialog.h"
#import "ASICacheDelegate.h"
#import "ASIDataCompressor.h"
#import "ASIDataDecompressor.h"
#import "ASIDownloadCache.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequestConfig.h"
#import "ASIHTTPRequestDelegate.h"
#import "ASINetworkQueue.h"
#import "ASIProgressDelegate.h"
#import "ASIWebPageRequest.h"
#import "ASIInputStream.h"
#import "NFSRTableViewController.h"

@class NFSRTableViewController;


@interface NFSRLoginViewController: UIViewController <UITextFieldDelegate>
{
    NSString *urlStr;
    IBOutlet UIButton *sigininClicked;
    NFSRTableViewController *tableView;
    NSUserDefaults *userDefaults;
    NSString *app_id;
    NSString *hexToken;
}

//@property (weak, nonatomic) IBOutlet UITextField *txtID;
//@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (retain, nonatomic) IBOutlet UITextField *txtID;
@property (retain, nonatomic) IBOutlet UITextField *txtPassword;
@property (retain, nonatomic) NSUserDefaults *saveID;
@property (retain, nonatomic) NSUserDefaults *savePW;


- (IBAction)sigininClicked_clik:(id)sender;
- (IBAction)textFieldReturn:(id)sender;
- (IBAction)backgroundTouched:(id)sender;

@property (strong, nonatomic) NFSRTableViewController *NFSRtableViewController;



@end