//
//  SRXMLRPCManager.h
//  sugarain
//
//  Created by SonMintak on 5/25/15.
//  Copyright (c) 2015 Mintak Son. All rights reserved.
//

#import "SRManager.h"
#import "SRXMLRPCRequest.h"

@class NFSRLoginViewController;

@interface SRXMLRPCManager : SRManager

@property(strong, nonatomic) NFSRLoginViewController *nfsrloginviewcontroller;

- (void) test;
/**
 method : Initialize
 @param  deviceId      디바이스 아이디. String. Required: Y
 @param  token         토큰값. String	Required: Y
 @param  deviceType    디바이스 종류(ANDROID, IOS). Enum('A', 'I')	. Requred: Y
 @param  alarm       - Enum('Y','N')
 
 @return	TRUE	정상적으로 요청이 성공하였을 경우			Boolean
 */
///////////////////////////////// 완료
- (void) app_id:(NSString *)appID requestInitializeWithDeviceId:(NSString *)deviceId token:(NSString *)token  isForced:(BOOL)isForced successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

@end
