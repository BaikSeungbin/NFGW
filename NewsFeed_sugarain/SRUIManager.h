//
//  SRUIManager.h
//  sugarain
//
//  Created by SonMintak on 4/25/15.
//  Copyright (c) 2015 Mintak Son. All rights reserved.
//

#import "SRManager.h"

typedef NS_ENUM(NSInteger, UIScreenType)
{
  UIScreenTypeUnknown = 0,
  UIScreenTypeiPhone4,
  UIScreenTypeiPhone5,
  UIScreenTypeiPhone6,
  UIScreenTypeiPhone6Plus,
};

@interface SRUIManager : SRManager

extern NSString * const colorClear;
extern NSString * const colorWhite;
extern NSString * const colorGray;
extern NSString * const colorBlack;
extern NSString * const colorRed;

// color
- (UIColor *) colorWithName:(NSString *)colorName;
- (UIColor *) colorWithName:(NSString *)colorName alpha:(CGFloat )alpha;

- (UIImage *) colorImageWithName:(NSString *)colorName;
- (UIImage *) colorImageWithName:(NSString *)colorName alpha:(CGFloat)alpha;
- (UIImage *) colorImageWithName:(NSString *)colorName alpha:(CGFloat)alpha size:(CGSize)size;

- (UIImage *) colorImageWithHexString:(NSString *)hexString;
- (UIImage *) colorImageWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
- (UIImage *) colorImageWithHexString:(NSString *)hexString alpha:(CGFloat)alpha size:(CGSize)size;

- (NSString *) hexStringWithColorName:(NSString *)colorName;
- (UIColor *) colorWithHexString:(NSString *)hexString;
- (UIColor *) colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;
- (UIColor *) colorWithInteger:(UInt32)integer;

// font
- (UIFont *) fontWithSize:(CGFloat)size;
- (UIFont *) lightFontWithSize:(CGFloat) size;
- (UIFont *) boldFontWithSize:(CGFloat)size;

// storyboard
- (UIStoryboard *) mainStoryboard;

// image
- (UIScreenType) screenType;
@end
