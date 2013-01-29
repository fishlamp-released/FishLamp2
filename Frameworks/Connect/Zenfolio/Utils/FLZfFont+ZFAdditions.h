//
//  NSFont+FLZfAdditions.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FishLampCocoa.h"

@interface NSFont (FLZfAdditions)

+ (NSFont*) zenfolioFontOfSize:(CGFloat)fontSize;

+ (NSFont*) boldZenfolioFontOfSize:(CGFloat)fontSize;

+ (NSFont*) zenfolioButtonFont;

+ (NSFont*) zenfolioButtonBarButtonFont;

+ (NSFont*) zenfolioLinkButtonFont;

+ (NSFont*) zenfolioLabelFont;

@end
