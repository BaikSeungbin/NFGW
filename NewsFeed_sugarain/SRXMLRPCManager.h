//
//  SRXMLRPCManager.h
//  sugarain
//
//  Created by SonMintak on 5/25/15.
//  Copyright (c) 2015 Mintak Son. All rights reserved.
//

#import "SRManager.h"
#import "SRXMLRPCRequest.h"

@interface SRXMLRPCManager : SRManager

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
- (void) requestInitializeWithDeviceId:(NSString *)deviceId token:(NSString *)token deviceType:(NSString *)deviceType alarm:(NSString *)alarm isForced:(BOOL)isForced successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 method :	Setup
 @param	디바이스 아이디			String	Y
 @param	알람여부			Enum('Y', 'N')	N
 @param	분야 (ex. 분야1|분야2|분야3|분야4|)			String	N
 @param	지역 (ex. 전국|해외|인천광역시|서울특별시|)			String	N
 
 @return TRUE	정상적으로 요청이 성공하였을 경우			Boolean
 */
///////////////////////////////// 완료
- (void) requestSetupWithDeviceId:(NSString *)deviceId alarmEnabled:(NSString *)alarmEnabled bunya:(NSString *)bunya area:(NSString *)area successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	PolicyNew
 @param	entries			String	Y     (들어가 있음)
 @param	페이징 번호			Number	N
 @param	페이지 당 게시물 수 (default 10)			Number	N
 @param	분야명 (선택)			String	N
 @param	검색어 (검색요청시만, 제목검색)			String	N
 @param	기관명 (검색요청시만)			String	N
 @param	지역명 (검색요청시만)			String	N
 @param	날짜 (검색요청시만, 2015-01-01 형식)			Date	N
 
 @return id	게시물 일련번호			Number
 @return subject	제목			String
 @return contents	내용			String
 @return organization	주관기관			String
 @return start_date	사업기간 (시작일)			Date
 @return end_date	사업기간 (종료일)			Date
 @return is_recommend	추천여부			Enum('Y','N')
 @return bunya	분야			array
 @return total_app_aha	aha 카운트			Number
 @return total_app_share	share카운트			Number
 */
- (void) requestPolicyNewByEntries:(NSNumber *)pagingNumber limit:(NSNumber *)limit bunya:(NSString *)bunya keyword:(NSString *)keyword organization:(NSString *)organization area:(NSString *)area date:(NSString *)date successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	PolicyNew
 @param date			String	Y   (들어가 있음)
 @param	페이징 번호			Number	N
 @param	페이지 당 게시물 수 (default 10)			Number	N
 @param	시작일 (2015-01-01)			Date	Y
 @param	종료일 (2015-02-15)			Date	Y
 
 @return id	게시물 일련번호			Number
 @return subject	제목			String
 @return contents	내용			String
 @return organization	주관기관			String
 @return start_date	사업기간 (시작일)			Date
 @return end_date	사업기간 (종료일)			Date
 @return is_recommend	추천여부			Enum('Y','N')
 @return bunya	분야			array
 @return total_app_aha	aha 카운트			Number
 @return total_app_share	share카운트			Number
 */
- (void) requestPolicyNewByDate:(NSNumber *)pagingNumber limit:(NSNumber *)limit startDate:(NSDate *)startDate endDate:(NSDate *)endDate successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	PolicyNew
 @param	organization			String	Y (들어가 있음)
 @param	페이징 번호			Number	N
 @param	페이지 당 게시물 수 (default 10)			Number	N
 @param	기관명			String	Y
 
 @return id	게시물 일련번호			Number
 @return subject	제목			String
 @return contents	내용			String
 @return organization	주관기관			String
 @return start_date	사업기간 (시작일)			Date
 @return end_date	사업기간 (종료일)			Date
 @return is_recommend	추천여부			Enum('Y','N')
 @return bunya	분야			array
 @return total_app_aha	aha 카운트			Number
 @return total_app_share	share카운트			Number
 */
- (void) requestPolicyNewByOrganization:(NSNumber *)pagingNumber limit:(NSNumber *)limit organization:(NSString *)organization successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	PolicyNew
 @param	latest			String	Y (들어가 있음)
 @param	페이징 번호			Number	N
 @param	페이지 당 게시물 수 (default 10)			Number	N
 @param	게시물 고유번호			Number	Y
 
 @return id	게시물 일련번호			Number
 @return subject	제목			String
 @return contents	내용			String
 @return organization	주관기관			String
 @return start_date	사업기간 (시작일)			Date
 @return end_date	사업기간 (종료일)			Date
 @return is_recommend	추천여부			Enum('Y','N')
 @return bunya	분야			array
 @return total_app_aha	aha 카운트			Number
 @return total_app_share	share카운트			Number
 */
- (void) requestPolicyNewByLatest:(NSNumber *)pagingNumber limit:(NSNumber *)limit policyId:(NSNumber *)policyId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	PolicyViewNew
 @param	게시물 일련번호			Number	Y
 @param	디바이스 아이디			String	N
 
 @return id	게시물 일련번호			Number
 @return subject	제목			String
 @return contents	내용			String
 @return organization	주관기관			String
 @return start_date	사업기간 (시작일)			Date
 @return end_date	사업기간 (종료일)			Date
 @return is_recommend	추천여부			Enum('Y','N')
 @return total_app_aha	aha 카운트			Number
 @return total_app_share	share카운트			Number
 @return aha_check	아하체크여부(파라미터에 디바이스 아이디 있을경우만)			('Y','N')
 @return bunya	분야			array
 */
- (void) requestPolicyViewNew:(NSString *)policyId deviceId:(NSString *)deviceId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	Comment
 @param	정책정보 게시물 일련번호 (755940 테스트 가능)			Number	Y
 
 @return name	작성자 명			String
 @return contents	내용			String
 @return created	작성일			Date
 */
- (void) requestComment:(NSNumber *)policyId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	Advertisement
 no param.
 
 @return id	광고 일련번호			Number
 @return title	광고 제목			String
 @return link	광고 링크 ('#' 일 경우 링크없게 처리)			String
 @return image	이미지 주소  			String
 */
///////////////////////////////// 완료
- (void) requestAdvertisement:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 URL http://aropa2.plani.co.kr/app/android/webview_new/id/정책정보게시물일련번호
 
 일련번호	파라미터	요청값	타입	필수여부
 @return id	정책정보 게시물 일련번호			Number	Y
 */

/**
 매소드	SetAhaNew
 @param	디바이스 아이디			String	Y
 @param	정책정보 게시물 일련번호			String	Y
 @param	아하체크 ('Y' : (디폴트)체크, 'N' : 체크취소)			Enum('Y','N')	N
 
 @return total_app_aha	aha 카운트			Number
 */
- (void) requestSetAhaNew:(NSString *)deviceId policyId:(NSString *)policyId ahaCheck:(NSString *)ahaCheck successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	SetShareNew
 @param	디바이스 아이디			String	Y
 @param	정책정보 게시물 일련번호			String	Y
 @param	SNS 종류 (email, facebook, twitter, google 등)			String	N
 
 @return total_app_share	share 카운트			Number
 */
- (void) requestSetShareNew:(NSString *)deviceId policyId:(NSString *)policyId snsType:(NSString *)snsType successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 매소드	Notice
 @param	페이징 번호			Number	N
 @param	페이지 당 게시물 수 (default 10)			Number	N
 
 @return id	공지사항 일련번호			Number
 @return subject	제목			String
 @return contents	내용			String
 @return created	생성일			Datetime
 @return category_id	카테고리 일련번호			Number
 @return category	카테고리명			String
 */
- (void) requestNotice:(NSNumber *)pagingNumber limit:(NSNumber *)limit successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler NS_UNAVAILABLE;

/**
 매소드	NoticeView
 @param	공지사항 일련번호			Number	Y

 @return id	공지사항 일련번호			Number
 @return subject	제목			String
 @return contents	내용			String
 @return created	생성일			Datetime
 @return category_id	카테고리 일련번호			Number
 @return category	카테고리명			String
 */
- (void) requestNoticeView:(NSNumber *)policyId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler NS_UNAVAILABLE;

/**
 매소드	GetInfo
 @param	디바이스 아이디			String	Y
 
 @return id	디바이스정보 고유번호			Number
 @return device_id	디바이스 아이디			String
 @return device_type	디바이스 종류			Enum('A', 'I')
 @return token	토큰			String
 @return alarm	알람			Enum('Y', 'N')
 @return bunya	분야			String
 @return area	지역			String
 @return badge (IOS) badge 수  Number
 */
- (void) requestGetInfo:(NSString *)deviceId successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 메소드 GetVersion
 
 @return version 서버에 설정된 버전정보 ex(1.01) String
 */
- (void) requestGetVersion:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 메소드 SetBadge
 @param	디바이스 아이디			String	Y
 @param 세팅하고자 하는 배지 수 Number  Y
 
 @return badge (세팅된 후) 배지 수 Number
 */
- (void) requestSetBadge:(NSString *)deviceId badge:(NSNumber *)badge successHandler:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;

/**
 메소드 GetClause
 
 @return useagree 이용약관
 @return infoagree 개인정보수집동의약관
 */
- (void) requestGetClause:(SRXMLRPCSuccessHandler)successHandler failHandler:(SRXMLRPCFailHandler)failHandler;
@end
