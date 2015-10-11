
//
//  SRXMLRPCManager.m
//  sugarain
//
//  Created by SonMintak on 5/25/15.
//  Copyright (c) 2015 Mintak Son. All rights reserved.
//

#import "SRXMLRPCManager.h"
#import "XMLRPC.h"

#import "SRFormatManager.h"


static NSString * const URLString = @"http://gw.plani.co.kr/app/ios/index";

@interface SRXMLRPCManager () <XMLRPCConnectionDelegate>

@end

@implementation SRXMLRPCManager
SHARED_SINGLETON_CLASS(SRXMLRPCManager);

- (id) init {
  if (self = [super init]) {
  }
  return self;
}

- (void) _requestWithMethod:(NSString *)method
                 parameters:(NSArray *)parameters
             successHandler:(SRXMLRPCSuccessHandler)successHandler
                failHandler:(SRXMLRPCFailHandler)failHandler{
  NSURL *URL = [NSURL URLWithString:URLString];
  SRXMLRPCRequest *request = [[SRXMLRPCRequest alloc] initWithURL:URL];
  request.successHandler = successHandler;
  request.failHandler = failHandler;
  [request setMethod:method withParameters:parameters];
  [((NSMutableURLRequest *)request.request) setValue:@"*" forHTTPHeaderField:@"Accept-Encoding"];
  
  XMLRPCConnectionManager *manager = [XMLRPCConnectionManager sharedManager];

  //ILog(@"\n\n\n[%@][%@]\n%@\n\n", method, parameters, request.body);
  
  [manager spawnConnectionWithXMLRPCRequest:request delegate:self];
}

#pragma mark -
- (void)request: (SRXMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
 // ILog(@"\n\n\n[%@]\n%@\n\n", request.method, response.body);
  if (response.isFault == NO) {
    if (request.successHandler)
      request.successHandler(response.object);
  } else {
    if (request.failHandler) {
      NSError *error = [NSError errorWithDomain:response.faultString code:response.faultCode.integerValue userInfo:nil];
      request.failHandler(error, nil);
    }
  }
}

- (void)request: (SRXMLRPCRequest *)request didSendBodyData: (float)percent {
  
}

- (void)request: (SRXMLRPCRequest *)request didFailWithError: (NSError *)error {
  if (request.failHandler)
    request.failHandler(nil, nil);
}

- (BOOL)request: (SRXMLRPCRequest *)request canAuthenticateAgainstProtectionSpace: (NSURLProtectionSpace *)protectionSpace {
  return YES;
}

- (void)request: (SRXMLRPCRequest *)request didReceiveAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge {
  
}

- (void)request: (SRXMLRPCRequest *)request didCancelAuthenticationChallenge: (NSURLAuthenticationChallenge *)challenge {
  
}

#pragma mark -
- (void) test {
//  [self requestPolicyNewByOrganization:@(2) limit:@(10) organization:@"산업통상자원부" successHandler:^(id XMLData) {
//    NSArray *array = [XMLData arrayWithKeyIndex];
//    NSArray *objects = [SRPost objectsFromXML:array];
//  } failHandler:^(NSError *error, id XMLData)
//  {
//    
//  }];
}

- (void) requestInitializeWithDeviceId:(NSString *)deviceId token:(NSString *)token deviceType:(NSString *)deviceType alarm:(NSString *)alarm isForced:(BOOL)isForced successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {

  static dispatch_once_t initializeOnceToken;
  if (isForced == YES)
    initializeOnceToken = 0;
  
  dispatch_once(&initializeOnceToken, ^{
    NSMutableArray *parameters = [[NSMutableArray alloc] init];
    [self _addObject:deviceId toParameters:parameters];
    [self _addObject:token toParameters:parameters];
    [self _addObject:deviceType toParameters:parameters];
    [self _addObject:alarm toParameters:parameters];
    
    [self _requestWithMethod:@"Initialize" parameters:parameters successHandler:successHandler failHandler:failHandler];
  });
}

- (void) requestSetupWithDeviceId:(NSString *)deviceId alarmEnabled:(NSString *)alarmEnabled bunya:(NSString *)bunya area:(NSString *)area successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:deviceId toParameters:parameters];
  [self _addObject:alarmEnabled toParameters:parameters];
  [self _addObject:bunya toParameters:parameters];
  [self _addObject:area toParameters:parameters];
  
  [self _requestWithMethod:@"Setup" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestPolicyNewByEntries:(NSNumber *)pagingNumber limit:(NSNumber *)limit bunya:(NSString *)bunya keyword:(NSString *)keyword organization:(NSString *)organization area:(NSString *)area date:(NSString *)date successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:@"entries" toParameters:parameters];
  [self _addObject:pagingNumber toParameters:parameters];
  [self _addObject:limit toParameters:parameters];
  [self _addObject:bunya toParameters:parameters];
  [self _addObject:keyword toParameters:parameters];
  [self _addObject:organization toParameters:parameters];
  [self _addObject:area toParameters:parameters];
  [self _addObject:date toParameters:parameters];
  
  [self _requestWithMethod:@"PolicyNew" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestPolicyNewByDate:(NSNumber *)pagingNumber limit:(NSNumber *)limit startDate:(NSDate *)startDate endDate:(NSDate *)endDate successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:@"date" toParameters:parameters];
  [self _addObject:pagingNumber toParameters:parameters];
  [self _addObject:limit toParameters:parameters];
  [self _addObject:[[SRFormatManager sharedManager] yearDayMonthDashWithDate:startDate] toParameters:parameters];
  [self _addObject:[[SRFormatManager sharedManager] yearDayMonthDashWithDate:endDate] toParameters:parameters];
  
  [self _requestWithMethod:@"PolicyNew" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestPolicyNewByOrganization:(NSNumber *)pagingNumber limit:(NSNumber *)limit organization:(NSString *)organization successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:@"organization" toParameters:parameters];
  [self _addObject:pagingNumber toParameters:parameters];
  [self _addObject:limit toParameters:parameters];
  [self _addObject:organization toParameters:parameters];
  
  [self _requestWithMethod:@"PolicyNew" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestPolicyNewByLatest:(NSNumber *)pagingNumber limit:(NSNumber *)limit policyId:(NSNumber *)policyId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:@"lastest" toParameters:parameters];
  [self _addObject:pagingNumber toParameters:parameters];
  [self _addObject:limit toParameters:parameters];
  [self _addObject:policyId toParameters:parameters];
  
  [self _requestWithMethod:@"PolicyNew" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestPolicyViewNew:(NSString *)policyId deviceId:(NSString *)deviceId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:policyId toParameters:parameters];
  [self _addObject:deviceId toParameters:parameters];
  
  [self _requestWithMethod:@"PolicyViewNew" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestComment:(NSNumber *)policyId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:policyId toParameters:parameters];
  
  [self _requestWithMethod:@"Comment" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestAdvertisement:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  
  [self _requestWithMethod:@"Advertisement" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestSetAhaNew:(NSString *)deviceId policyId:(NSString *)policyId ahaCheck:(NSString *)ahaCheck successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:deviceId toParameters:parameters];
  [self _addObject:policyId toParameters:parameters];
  [self _addObject:ahaCheck toParameters:parameters];
  
  [self _requestWithMethod:@"SetAhaNew" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestSetShareNew:(NSString *)deviceId policyId:(NSNumber *)policyId snsType:(NSString *)snsType successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:deviceId toParameters:parameters];
  [self _addObject:policyId toParameters:parameters];
  [self _addObject:snsType toParameters:parameters];
  
  [self _requestWithMethod:@"SetShareNew" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestNotice:(NSNumber *)pagingNumber limit:(NSNumber *)limit successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:pagingNumber toParameters:parameters];
  [self _addObject:limit toParameters:parameters];
  
  [self _requestWithMethod:@"Notice" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestNoticeView:(NSNumber *)policyId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:policyId toParameters:parameters];
  
  [self _requestWithMethod:@"NoticeView" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestGetInfo:(NSString *)deviceId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:deviceId toParameters:parameters];
  
  [self _requestWithMethod:@"GetInfo" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestGetVersion:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  [self _requestWithMethod:@"GetVersion" parameters:nil successHandler:successHandler failHandler:failHandler];
}

- (void) requestSetBadge:(NSString *)deviceId badge:(NSNumber *)badge successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  NSMutableArray *parameters = [[NSMutableArray alloc] init];
  [self _addObject:deviceId toParameters:parameters];
  [self _addObject:badge toParameters:parameters];
  
  [self _requestWithMethod:@"SetBadge" parameters:parameters successHandler:successHandler failHandler:failHandler];
}

- (void) requestGetClause:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
  [self _requestWithMethod:@"GetClause" parameters:nil successHandler:successHandler failHandler:failHandler];
}

#pragma mark -
- (void) _addObject:(id)object toParameters:(NSMutableArray *)parameters {
  if (object == nil)
    [parameters addObject:@""];
  else
    [parameters addObject:object];
}
@end
