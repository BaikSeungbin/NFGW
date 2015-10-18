//
//  UIViewController+NFSRTableView.m
//  NewsFeed_sugarain
//
//  Created by SBHR on 2015. 10. 3..
//  Copyright © 2015년 seungbin.baik. All rights reserved.
//
//된다!!!
#import "NFSRTableViewController.h"
#import "NFSRDetailViewController.h"
#import "TFHpple.h"
#import "Tutorial.h"
#import "Contributor.h"
#import "NFSRLoginViewController.h"

@interface NFSRTableViewController () {
    
    NSMutableArray *_objects;
    NSMutableArray *_contributors;
}

@end

@implementation NFSRTableViewController

@synthesize detailViewController = _detailViewController;
@synthesize loginviewcontroller = _loginviewcontroller;


int rowNo;



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"NewsFeed", @"Detail");
    }
    return self;
}

- (void)resetData
{
    
    NSURL *url = [NSURL URLWithString:@"http://gw.plani.co.kr/login/accounts/do_login/redirect/eNortjK0UtJXsgZcMAkSAcc.."];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.loginviewcontroller.txtID forKey:@"userid"];
    [request setPostValue:self.loginviewcontroller.txtPassword forKey:@"passwd"];
    
    [request setDelegate:self];
    [request startSynchronous];
    [request setCompletionBlock:^{
        [request responseString];
        
    }];
        [request setFailedBlock:^{

    }];
    

    
    NSString *path=@"";
    NSError *error;
    NSString *stringFromURL = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://gw.plani.co.kr/feeds"] encoding:NSUTF8StringEncoding error:&error];
    if(stringFromURL == nil)
    {
        NSLog(@"Error reading URL at %@\n%@", path, [error localizedFailureReason]);
        
    }
    arrNewsList=[[NSMutableArray alloc] init];
    linkurl=[[NSMutableArray alloc] init];
    
    NSData *data = [stringFromURL dataUsingEncoding:NSUnicodeStringEncoding];
    
    //Create parser
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:data];
    
    NSArray *elements=[xpathParser searchWithXPathQuery:XPATH_QUERY];
    for(int i=0;i<[elements count];i++)
    {
        NSLog(@"%@",[[elements objectAtIndex:i] content]);
        NSLog(@"%@", [[[elements objectAtIndex:i]attributes]valueForKey:@"href"]);

    TFHppleElement *element=[elements objectAtIndex:i] ;
    TFHppleElement *urls = [elements objectAtIndex:i];
        
        // 목록을 배열에 저장한다.
        [arrNewsList addObject:[[element firstChild] content]];
        [linkurl addObject:[[urls attributes]valueForKey:@"href"]];
        NSLog(@"%@", arrNewsList);
        NSLog(@"%@", linkurl);
    // 사용한 변수들을 메모리에서 제거.

    xpathParser=nil;
    element=nil;
    urls =nil;

}
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationController.navigationBarHidden = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"app_id"] == nil) {
        //Load Login View if no username is found
        NSLog(@"No username found");
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"로그인 실패"
                                      message:@"로그인을 다시 시도해주시기 바랍니다."
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 
                                 
                                 NFSRLoginViewController *loginView =[self.storyboard instantiateViewControllerWithIdentifier:@"NFSRLoginViewController"];
                                 [loginView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                                 [self presentViewController:loginView animated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     exit(0);
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];

    }
    else {
        
        [self resetData];
        
       }
}


//셀 설정
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *strCellReuseId=@"CELL_LIST";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCellReuseId];
    
    //셀 초기화 부분 수정 => 데이터가 있음에도 초기화되는 현상 해결
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];//WithStyle:UITableViewCellStyleSubtitle reuseIdentifier:strCellReuseId];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text=[arrNewsList objectAtIndex:indexPath.row];
    }
    
    
    return cell;
}


- (IBAction)sigininClicked_clik:(id)sender {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"saveID"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"savePW"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"MySavedCookies"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"app_id"];
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    NFSRLoginViewController *loginView =[self.storyboard instantiateViewControllerWithIdentifier:@"NFSRLoginViewController"];
    [loginView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentViewController:loginView animated:YES completion:nil];
}

- (IBAction)sigininClicked_refresh:(id)sender {
    [self resetData];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    urlStr = [linkurl objectAtIndex:indexPath.row];
    BOOL prefix = [urlStr hasPrefix:@"http//gw.plani.co.kr/"];
    if (!prefix)
    {
        urlStr2=[@"http://gw.plani.co.kr/" stringByAppendingString: urlStr];
    }
    

        
    NSLog(@"%@",urlStr2);
    NSURL *url = [NSURL URLWithString:urlStr2];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    NSLog(@"%@", requestURL);
    [self.detailViewController.webView loadRequest:requestURL];
    if (!self.detailViewController) {
        self.detailViewController = [[NFSRDetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
   
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_logOut release];
    [_refresh release];
    [super dealloc];
}
@end
