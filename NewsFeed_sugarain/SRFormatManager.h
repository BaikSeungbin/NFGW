//
//  SRFormatManager.h
//  sugarain
//
//  Created by SonMintak on 5/6/15.
//  Copyright (c) 2015 Mintak Son. All rights reserved.
//

#import "SRManager.h"

@interface SRFormatManager : SRManager
- (NSString *) dayMonthYearWithDateEnglish:(NSDate *)date;
- (NSString *) yearDayMonthKoreanWithDate:(NSDate *)date;
- (NSString *) yearDayMonthDashWithDate:(NSDate *)date;
- (NSString *) yearDayMonthDotWithDate:(NSDate *)date;
- (NSString *) yearMonthDayTimeWithDate:(NSDate *)date; // 2015-03-23 오전 12:00 형태
@end
