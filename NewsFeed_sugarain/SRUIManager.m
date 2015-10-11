//
//  SRUIManager.m
//  sugarain
//
//  Created by SonMintak on 4/25/15.
//  Copyright (c) 2015 Mintak Son. All rights reserved.
//

#import "SRUIManager.h"
//#import <UIColor-Utilities/UIColor+Expanded.h>

static NSString * colorListFileName = @"Colors";
static NSString * colorListFileExtension = @"plist";

// color
NSString * const colorClear = @"colorClear";
NSString * const colorWhite = @"colorWhite";
NSString * const colorGray = @"colorGray";
NSString * const colorBlack = @"colorBlack";
NSString * const colorRed = @"colorRed";

@interface SRUIManager () {
  NSDictionary *_colorHexDictionary;
  NSMutableDictionary *_colorDictionary;
}
@end

@implementation SRUIManager
SHARED_SINGLETON_CLASS(SRUIManager)

- (id) init {
  if (self = [super init]) {
    _colorDictionary = [[NSMutableDictionary alloc] init];
    
    [self _loadColors];
    [self _setUIAppearance];
  }
  return self;
}

#pragma mark - colors
- (void) _loadColors {
  _colorHexDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:colorListFileName
                                                                                                   ofType:colorListFileExtension]];
  
  [_colorHexDictionary enumerateKeysAndObjectsUsingBlock:^(NSString *colorName, NSString *colorHexString, BOOL *stop) {
    UIColor *color = nil;
    if (colorHexString.length == 7) {
      color = [UIColor colorWithHexString:colorHexString];
    } else if (colorHexString.length == 9) {
      // for color with alpha
      color = [UIColor colorAndAlphaWithHexString:[colorHexString stringByReplacingOccurrencesOfString:@"#"
                                                                                            withString:@""]];
    }
    
    NSAssert(color != nil, @"%@ - %@ => color : nil", colorName, colorHexString);
    
    if (color != nil) {
      [_colorDictionary setObject:color forKey:colorName];
    }
  }];
}

- (UIColor *) colorWithName:(NSString *)colorName {
  NSAssert(colorName != nil, @"colorName should not be nil.");
  
  return [_colorDictionary objectForKey:colorName];
}

- (UIColor *) colorWithName:(NSString *)colorName alpha:(CGFloat )alpha {
  NSAssert(colorName != nil, @"colorName should not be nil.");
  
  NSString *colorNameWithAlpha = [colorName stringByAppendingFormat:@"_%.3f", alpha];
  UIColor *color = [_colorDictionary objectForKey:colorNameWithAlpha];
  if (color == nil) {
    color = [[self colorWithName:colorName] colorWithAlphaComponent:alpha];
    [_colorDictionary setObject:color forKey:colorNameWithAlpha];
  }
  
  return color;
}

- (UIImage *) colorImageWithName:(NSString *)colorName {
  return [self colorImageWithName:colorName alpha:1.0f];
}

- (UIImage *) colorImageWithName:(NSString *)colorName alpha:(CGFloat)alpha {
  return [self colorImageWithName:colorName alpha:alpha size:CGSizeMake(1.0f, 1.0f)];
}

- (UIImage *)colorImageWithName:(NSString *)colorName alpha:(CGFloat)alpha size:(CGSize)size {
  static NSMutableDictionary *colorImageDictionary = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    colorImageDictionary = [[NSMutableDictionary alloc] init];
  });
  
  NSString *key = [NSString stringWithFormat:@"%@_%.2f", colorName, alpha];
  
  UIImage *colorImage = [colorImageDictionary objectForKey:key];
  if (colorImage == nil)
  {
    colorImage = [UIImage imageWithUIColor:[self colorWithName:colorName alpha:alpha] size:size];
    [colorImageDictionary setObject:colorImage forKey:key];
  }
  
  return colorImage;
}

- (UIImage *) colorImageWithHexString:(NSString *)hexString {
  return [self colorImageWithHexString:hexString alpha:1.0f];
}

- (UIImage *) colorImageWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
  return [self colorImageWithHexString:hexString alpha:1.0f size:CGSizeMake(1.0f, 1.0f)];
}

- (UIImage *) colorImageWithHexString:(NSString *)hexString alpha:(CGFloat)alpha size:(CGSize)size {
  static NSMutableDictionary *colorImageWithHexStringDictionary = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    colorImageWithHexStringDictionary = [[NSMutableDictionary alloc] init];
  });
  
  NSString *key = [NSString stringWithFormat:@"%@_%.2f", hexString, alpha];
  
  UIImage *colorImage = [colorImageWithHexStringDictionary objectForKey:key];
  if (colorImage == nil)
  {
    colorImage = [UIImage imageWithUIColor:[self colorWithHexString:hexString alpha:alpha] size:size];
    [colorImageWithHexStringDictionary setObject:colorImage forKey:key];
  }
  
  return colorImage;
}


- (NSString *) hexStringWithColorName:(NSString *)colorName {
  return [_colorHexDictionary objectForKey:colorName];
}

- (UIColor *) colorWithHexString:(NSString *)hexString {
  return [UIColor colorWithHexString:hexString];
}

- (UIColor *) colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
  return [[UIColor colorWithHexString:hexString] colorWithAlphaComponent:alpha];
}

- (UIColor *) colorWithInteger:(UInt32)integer {
  return [UIColor colorWithRGBHex:integer];
}

#pragma mark - fonts
- (UIFont *) fontWithSize:(CGFloat)size {
  return [UIFont systemFontOfSize:size];
}

- (UIFont *) lightFontWithSize:(CGFloat)size {
  return [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:size];
}

- (UIFont *) boldFontWithSize:(CGFloat)size {
  return [UIFont boldSystemFontOfSize:size];
}

#pragma mark - storyboard
- (UIStoryboard *) mainStoryboard {
  return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

#pragma mark -
- (UIScreenType) screenType {
  CGFloat greaterPixelDimension = (CGFloat) fmaxf(((float)[[UIScreen mainScreen]bounds].size.height),
                                                  ((float)[[UIScreen mainScreen]bounds].size.width));
  
  switch ((NSInteger)greaterPixelDimension) {
    case 480:
      return UIScreenTypeiPhone4;
      break;
    case 568:
      return UIScreenTypeiPhone5;
      break;
    case 667:
      return UIScreenTypeiPhone6;
      break;
    case 736:
      return UIScreenTypeiPhone6Plus;
      break;
    default:
      return UIScreenTypeUnknown;
      break;
  }
}

#pragma mark -
- (void) _setUIAppearance {
  [[UIView appearance] setTintColor:[self colorWithName:colorRed]];
  
  [[UINavigationBar appearance] setTintColor:[self colorWithHexString:@"#333333"]];
  
  [[UISwitch appearance] setOnTintColor:[self colorWithName:colorRed]];
}

@end