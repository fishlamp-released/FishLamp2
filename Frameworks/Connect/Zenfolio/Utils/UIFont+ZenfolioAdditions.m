//
//  UIFont+FLZenfolioFont.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "UIFont+ZenfolioAdditions.h"

@implementation UIFont (ZenfolioAdditions)

+ (UIFont *)zenfolioFontOfSize:(CGFloat)fontSize {
    UIFont* font = [UIFont fontWithName:@"MyriadPro-Regular" size:fontSize];
    FLAssertNotNil(font);
    return font;
}

+ (UIFont *)boldZenfolioFontOfSize:(CGFloat)fontSize {
    UIFont* font = [UIFont fontWithName:@"MyriadPro-Bold" size:fontSize];
    FLAssertNotNil(font);
    return font;
}

#if OSX
+ (UIFont *) zenfolioButtonFont {
    return [UIFont boldZenfolioFontOfSize:[UIFont systemFontSizeForControlSize:NSRegularControlSize]];
}

+ (UIFont *) zenfolioButtonBarButtonFont {
    return [UIFont zenfolioFontOfSize:[UIFont systemFontSizeForControlSize:NSMiniControlSize]];
}

+ (UIFont*) zenfolioLinkButtonFont {
    return [UIFont zenfolioFontOfSize:[UIFont systemFontSizeForControlSize:NSRegularControlSize]];
}

+ (UIFont*) zenfolioLabelFont {
    return [UIFont boldZenfolioFontOfSize:[UIFont systemFontSizeForControlSize:NSRegularControlSize]];
}
#else 
+ (UIFont *) zenfolioButtonFont {
    return [UIFont boldZenfolioFontOfSize:[UIFont systemFontSize]];
}

+ (UIFont *) zenfolioButtonBarButtonFont {
    return [UIFont zenfolioFontOfSize:[UIFont smallSystemFontSize]];
}

+ (UIFont*) zenfolioLinkButtonFont {
    return [UIFont zenfolioFontOfSize:[UIFont systemFontSize]];
}

+ (UIFont*) zenfolioLabelFont {
    return [UIFont boldZenfolioFontOfSize:[UIFont systemFontSize]];
}

#endif
@end
