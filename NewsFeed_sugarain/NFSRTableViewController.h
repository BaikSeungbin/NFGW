//
//  UIViewController+NFSRTableView.h
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
#import "NFSRLoginViewController.h"

@class NFSRDetailViewController;
@class NFSRLoginViewController;

#define XPATH_QUERY @"//html//body//div[@class='container']//div//div[@class='main_desk col-md-9 col-lg-10 snap-content']//section//div[@class='gw_feed feeds_page']//ul//li//span//a"
#define XPATH_URL @"//html//body//div[@class='container']//div//div[@class='main_desk col-md-9 col-lg-10 snap-content']//section//div[@class='gw_feed feeds_page']//ul//li//span//a//@href"
//#define XPATH_QUERY2 @"//html//body//div[@class='container']//div//div[@class='main_desk col-md-9 col-lg-10 snap-content']//section//table//tbody//tr/td[@class='ellipsis'//a"
#define TARGET_URL @"http://gw.plani.co.kr/feeds"



@interface NFSRTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *arrNewsList;
    NSString *urlStr;
    NSMutableArray *linkurl;
    NSMutableArray *arrList;
    NFSRLoginViewController *firstView;
    NSUserDefaults *userDefaults;
    
}

@property (strong, nonatomic) NFSRDetailViewController *detailViewController;
@property (strong, nonatomic) NFSRLoginViewController *loginviewcontroller;
@property (retain, nonatomic) IBOutlet UIButton *logOut;


@end