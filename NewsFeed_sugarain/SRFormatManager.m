//
//  SRFormatManager.m
//  sugarain
//
//  Created by SonMintak on 5/6/15.
//  Copyright (c) 2015 Mintak Son. All rights reserved.
//

#import "SRFormatManager.h"

@implementation SRFormatManager

SHARED_SINGLETON_CLASS(SRFormatManager);

- (NSString *) dayMonthYearWithDateEnglish:(NSDate *)date {
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
  });
  return [[dateFormatter stringFromDate:date] uppercaseString];
}

- (NSString *) yearDayMonthKoreanWithDate:(NSDate *)date {
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy년 M월 d일"];
  });
  return [dateFormatter stringFromDate:date];
}

- (NSString *) yearDayMonthDashWithDate:(NSDate *)date {
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
  });
  return [dateFormatter stringFromDate:date];
}

- (NSString *) yearDayMonthDotWithDate:(NSDate *)date {
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
  });
  return [dateFormatter stringFromDate:date];
}

- (NSString *) yearMonthDayTimeWithDate:(NSDate *)date {
  static NSDateFormatter *dateFormatter = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"ko-KR"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd a hh:mm"];
  });
  return [dateFormatter stringFromDate:date];
}
@end
