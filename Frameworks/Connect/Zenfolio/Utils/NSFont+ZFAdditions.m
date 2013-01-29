//
//  NSFont+FLZfFont.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSFont+FLZfAdditions.h"

@implementation NSFont (FLZfAdditions)

+ (NSFont *)zenfolioFontOfSize:(CGFloat)fontSize {
    NSFont* font = [NSFont fontWithName:@"MyriadPro-Regular" size:fontSize];
    FLAssertNotNil_(font);
    return font;
}

+ (NSFont *)boldZenfolioFontOfSize:(CGFloat)fontSize {
    NSFont* font = [NSFont fontWithName:@"MyriadPro-Bold" size:fontSize];
    FLAssertNotNil_(font);
    return font;
}

+ (NSFont *) zenfolioButtonFont {
    return [NSFont boldZenfolioFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]];
}

+ (NSFont *) zenfolioButtonBarButtonFont {
    return [NSFont zenfolioFontOfSize:[NSFont systemFontSizeForControlSize:NSMiniControlSize]];
}

+ (NSFont*) zenfolioLinkButtonFont {
    return [NSFont zenfolioFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]];
}

+ (NSFont*) zenfolioLabelFont {
    return [NSFont boldZenfolioFontOfSize:[NSFont systemFontSizeForControlSize:NSRegularControlSize]];
}

@end
