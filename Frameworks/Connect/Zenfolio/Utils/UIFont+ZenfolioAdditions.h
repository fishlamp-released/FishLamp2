//
//  UIFont+ZenfolioAdditions.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCompatibility.h"

@interface UIFont (ZenfolioAdditions)

+ (UIFont*) zenfolioFontOfSize:(CGFloat)fontSize;

+ (UIFont*) boldZenfolioFontOfSize:(CGFloat)fontSize;

+ (UIFont*) zenfolioButtonFont;

+ (UIFont*) zenfolioButtonBarButtonFont;

+ (UIFont*) zenfolioLinkButtonFont;

+ (UIFont*) zenfolioLabelFont;

@end
