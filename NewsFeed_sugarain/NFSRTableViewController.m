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
        // 요청한 내용이 성공헀을 경우에 대한 처리
        [self alertStatus:@"$$로그인 성공하였습니다." :@"Success" :0];
        
    }];
    
    [request setFailedBlock:^{
        // 요청한 내용이 실패했을 경우에 대한 처리
        [self alertStatus:@"$$로그인 실패하였습니다." :@"잘못된 정보" :0];
    }];
    
    
    NSString *path=@"";
    NSError *error;
    NSString *stringFromURL = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://gw.plani.co.kr/feeds"] encoding:NSUTF8StringEncoding error:&error];
    if(stringFromURL == nil)
    {
        NSLog(@"Error reading URL at %@\n%@", path, [error localizedFailureReason]);
        
    }
    /*
     NSURL *url2 = [NSURL URLWithString:@"http://gw.plani.co.kr/main"];
     
     NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url2];
     
     NSHTTPURLResponse *response;
     
     //요청 수행
     NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
     
     //헤더를 가져와 표시
     NSDictionary *headers = [response allHeaderFields];
     NSLog(@"Headers = %@", headers);
     //set-cookie 헤더를 추출한 후 이를 나눠 쿠키에 집어 넣는다.
     NSArray *cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:headers forURL:url2];
     
     // 이름이 app_id인 쿠키를 검색한다.
     for(NSHTTPCookie *cookie in cookies){
     NSLog(@"Cookie: %@", cookie);
     if([[cookie name] isEqualToString:@"app_id"]){
     NSLog(@" Found appID");
     }
     
     }*/
    
    
    
#pragma mark save array list
    // 배열 초기화
    arrNewsList=[[NSMutableArray alloc] init];
    
    // URL선언.
    NSString *urlServer=[TARGET_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    // html을 가져온다.
    NSData *htmlData=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlServer]];
    
    // 가져온 html을 Hpple에 전달 & 파싱.
    TFHpple *xpathParser=[[TFHpple alloc] initWithHTMLData:htmlData];
    
    // 파싱은 여기서 이루어짐, NSDictionary형으로된 파싱된 데이터를 NSArray에 저장.
    NSArray *elements=[xpathParser searchWithXPathQuery:XPATH_QUERY];
    
    // NSArray로된 배열에서 파싱된 데이터를 꺼내온다.
    for(int n=0;n<[elements count];n++)
    {
        // 가져온 파싱된 정보들을 NSDictionary에서 Hpple에서 사용가능한 데이터 형으로 바꾼다.
        TFHppleElement *element=[elements objectAtIndex:n];
        
        // 목록을 배열에 저장한다.
        [arrNewsList addObject:[[element firstChild] content]];
        
        
        // 사용한 변수들을 메모리에서 제거.
        element=nil;
        
        
        // url링크 주소 담기
        linkurl=[[NSMutableArray alloc] init];
        NSString *urlServer=[TARGET_URL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSData *htmlData=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlServer]];
        TFHpple *xpathParser=[[TFHpple alloc] initWithHTMLData:htmlData];
        NSArray *elements=[xpathParser searchWithXPathQuery:XPATH_URL];
        for(int n=0;n<[elements count];n++)
        {
            TFHppleElement *element=[elements objectAtIndex:n];
            [linkurl addObject:[[element firstChild] content]];
            element=nil;
        }
        
        //변수 전체 제거
        urlServer=nil;
        htmlData=nil;
        xpathParser=nil;
        elements=nil;
        
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
                                 //[alert dismissViewControllerAnimated:YES completion:nil];
                                 //[self presentViewController:alert animated:YES completion:nil];
                                 
                                 NFSRLoginViewController *loginView =[self.storyboard instantiateViewControllerWithIdentifier:@"NFSRLoginViewController"];
                                 [loginView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
                                 [self presentViewController:loginView animated:YES completion:nil];
                                 
                             }];
        UIAlertAction* cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     //[alert dismissViewControllerAnimated:YES completion:nil];
                                     exit(0);
                                 }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
/*
        NFSRLoginViewController *loginView =[self.storyboard instantiateViewControllerWithIdentifier:@"NFSRLoginViewController"];
        [loginView setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        [self presentViewController:loginView animated:YES completion:nil];
        //[self.view.window.rootViewController presentViewController:loginView animated:YES completion:nil];*/
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


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    urlStr = [linkurl objectAtIndex:indexPath.row];
    
    BOOL prefix = [urlStr hasPrefix:@"http//gw.plani.co.kr/"];
    if (!prefix)
    {
        urlStr=[@"http://gw.plani.co.kr/" stringByAppendingString: urlStr];
    }
    
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    /*[self.detailViewController.webView loadRequest:requestURL];
    
    NFSRDetailViewController *detailView = [self.storyboard instantiateViewControllerWithIdentifier:@"NFSRDetailViewController"];
    
    //NFSRDetailViewController *detailView = [[NFSRDetailViewController alloc] init];
    if (!self.detailViewController) {
        [self.storyboard instantiateViewControllerWithIdentifier:@"NFSRDetailViewController"];
    }
    [self.navigationController pushViewController:detailView animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    */
    [self.detailViewController.webView loadRequest:requestURL];
    if (!self.detailViewController) {
        self.detailViewController = [[NFSRDetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    }
    //[self.view addSubview:detailView.view];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return UITableViewCellEditingStyleInsert;
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 여기서 항목 삭제
}

*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_logOut release];
    [_refresh release];
    [super dealloc];
}
@end
