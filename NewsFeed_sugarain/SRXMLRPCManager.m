
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
@synthesize nfsrloginviewcontroller = _nfsrloginviewcontroller;

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
    
    NSLog(@"\n\n\n[%@][%@]\n%@\n\n", method, parameters, request.body);
    
    [manager spawnConnectionWithXMLRPCRequest:request delegate:self];
}

#pragma mark -
- (void)request: (SRXMLRPCRequest *)request didReceiveResponse: (XMLRPCResponse *)response {
    
    /*if([[response.object name] isEqualToString:@"member_id"]){
     NSLog(@" Found the app_id");
     }*/
    
    NSLog(@"\n\n\n[%@]\n%@\n\n", request.method, response.body);
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



- (void) app_id:(NSString *)appID requestInitializeWithDeviceId:(NSString *)deviceId token:(NSString *)token  isForced:(BOOL)isForced successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler {
    
    static dispatch_once_t initializeOnceToken;
    if (isForced == YES)
        initializeOnceToken = 0;
    
    dispatch_once(&initializeOnceToken, ^{
        NSMutableArray *parameters = [[NSMutableArray alloc] init];
        [self _addObject:appID toParameters:parameters];
        [self _addObject:deviceId toParameters:parameters];
        [self _addObject:token toParameters:parameters];
        
        
        [self _requestWithMethod:@"UpdateDeviceID" parameters:parameters successHandler:successHandler failHandler:failHandler];
    });
}




#pragma mark -
- (void) _addObject:(id)object toParameters:(NSMutableArray *)parameters {
    if (object == nil)
        [parameters addObject:@""];
    else
        [parameters addObject:object];
}
@end
