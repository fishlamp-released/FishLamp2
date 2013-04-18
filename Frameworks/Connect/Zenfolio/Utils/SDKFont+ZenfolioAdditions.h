//
//  SDKFont+ZenfolioAdditions.h
//  Zenfolio FishLamp
//
//  Created by Mike Fullerton on 12/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCompatibility.h"

#if UNAVAILABLE

@interface SDKFont (ZenfolioAdditions)

+ (SDKFont*) zenfolioFontOfSize:(CGFloat)fontSize;

+ (SDKFont*) boldZenfolioFontOfSize:(CGFloat)fontSize;

+ (SDKFont*) zenfolioButtonFont;

+ (SDKFont*) zenfolioButtonBarButtonFont;

+ (SDKFont*) zenfolioLinkButtonFont;

+ (SDKFont*) zenfolioLabelFont;

@end

#endif