//
//  UIViewController+NFSRLoginViewController.m
//  NewsFeed_sugarain
//
//  Created by SBHR on 2015. 10. 3..
//  Copyright © 2015년 seungbin.baik. All rights reserved.
//
#include <stdlib.h>

#import "NFSRTableViewController.h"
#import "NFSRLoginViewController.h"

@interface NFSRLoginViewController ()

@end
@implementation NFSRLoginViewController
SHARED_SINGLETON_CLASS(NFSRLoginViewController);

@synthesize srxmlrpcmanager =_srxmlrpcmanager;
@synthesize NFSRtableViewController = _NFSRTableViewController;

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
    
    const unsigned *tokenBytes = [devToken bytes];
    NSString *hexToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                          ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                          ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                          ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
    
}

- (IBAction)textFieldReturn:(id)sender{
    [sender resignFirstResponder];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title=@"iSmart Newsfeed";
    }
    return self;
}

- (void)viewDidLoad {
     self.navigationController.navigationBarHidden = YES;
    [[NFSRTableViewController alloc]init];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)sigininClicked_clik:(id)sender {
    // NSString *userID = [NSString stringWithFormat: @"%@", _txtID.text];
    // NSString *userPW = [NSString stringWtihFormat: @"%@", _txtPassword.text];
    
    if([[self.txtID text] isEqualToString:@""] || [[self.txtPassword text] isEqualToString:@""] ) {
        
        [self alertStatus:@"아이디와 비밀번호를 입력해주세요." :@"잘못된 정보" :0];
    }
    
    else{
        
        NSURL *url = [NSURL URLWithString:@"http://gw.plani.co.kr/login/accounts/do_login/redirect/eNortjK0UtJXsgZcMAkSAcc.."];
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:self.txtID.text forKey:@"userid"];
        [request setPostValue:self.txtPassword.text forKey:@"passwd"];
        [request setPostValue:@"Y" forKey:@"autologin"];
        [request setDelegate:self];
        [request startSynchronous];
        
        NSString *userID = _txtID.text;
        NSString *userPW = _txtPassword.text;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:userID forKey:@"saveID"];
        [prefs setObject:userPW forKey:@"savePW"];
        NSLog(@"@textID = > %@",userID);
        NSLog(@"@textpw = > %@",userPW);
        
        if (url.absoluteString == NULL) {
            url = [NSURL URLWithString:@"http://gw.plani.co.kr"];
        }
        
        NSArray *cookiesForDomain = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://gw.plani.co.kr"]];
        NSMutableURLRequest *newRequest = [NSMutableURLRequest requestWithURL:url];
        
        for (NSHTTPCookie *cookie in cookiesForDomain) {
            
            NSString *cookieString = [NSString stringWithFormat:@"%@=%@", [cookie name], [cookie value]];
            
            [newRequest setValue:cookieString forHTTPHeaderField:@"Cookie"];
            
            if([[cookie name]  isEqualToString: @"app_id"]){
                NSString *Login_id = [NSString stringWithFormat: @"%@",[cookie value]];
                NSLog(@"login ID is %@",Login_id);
                [prefs setObject:Login_id forKey:@"app_id"];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSString *deviceToken = [defaults objectForKey:@"deviceToken_id"];
                    NSLog(@"deviceToken: %@", deviceToken);
                    
                    
                    [[SRXMLRPCManager sharedManager]app_id:[defaults objectForKey:@"app_id"]
                                requestInitializeWithDeviceId:[SRSettingsManager sharedManager].device_id
                                                        token:deviceToken
                                                     isForced:NO
                                               successHandler:^(id XMLData) {
                                               } failHandler:^(NSError *error, id XMLData) {
                                                   
                                               }];

            }
        }
               
        
       
        NFSRTableViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MainNavigation"];
        [controller setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:controller animated:YES completion:nil];
    }

}



- (void) alertStatus:(NSString *)msg :(NSString *)title :(int) tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
}




-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


- (void)dealloc {
    [_txtID release];
    [_txtPassword release];
    [super dealloc];
}

@end
