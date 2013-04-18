//
//  SDKFont+ZFFont.m
//  Zenfolio Composer
//
//  Created by Mike Fullerton on 12/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "SDKFont+ZenfolioAdditions.h"

@implementation SDKFont (ZenfolioAdditions)

+ (SDKFont *)zenfolioFontOfSize:(CGFloat)fontSize {
    SDKFont* font = [SDKFont fontWithName:@"MyriadPro-Regular" size:fontSize];
    FLAssertNotNil(font);
    return font;
}

+ (SDKFont *)boldZenfolioFontOfSize:(CGFloat)fontSize {
    SDKFont* font = [SDKFont fontWithName:@"MyriadPro-Bold" size:fontSize];
    FLAssertNotNil(font);
    return font;
}

#if OSX
+ (SDKFont *) zenfolioButtonFont {
    return [SDKFont boldZenfolioFontOfSize:[SDKFont systemFontSizeForControlSize:NSRegularControlSize]];
}

+ (SDKFont *) zenfolioButtonBarButtonFont {
    return [SDKFont zenfolioFontOfSize:[SDKFont systemFontSizeForControlSize:NSMiniControlSize]];
}

+ (SDKFont*) zenfolioLinkButtonFont {
    return [SDKFont zenfolioFontOfSize:[SDKFont systemFontSizeForControlSize:NSRegularControlSize]];
}

+ (SDKFont*) zenfolioLabelFont {
    return [SDKFont boldZenfolioFontOfSize:[SDKFont systemFontSizeForControlSize:NSRegularControlSize]];
}
#else 
+ (SDKFont *) zenfolioButtonFont {
    return [SDKFont boldZenfolioFontOfSize:[SDKFont systemFontSize]];
}

+ (SDKFont *) zenfolioButtonBarButtonFont {
    return [SDKFont zenfolioFontOfSize:[SDKFont smallSystemFontSize]];
}

+ (SDKFont*) zenfolioLinkButtonFont {
    return [SDKFont zenfolioFontOfSize:[SDKFont systemFontSize]];
}

+ (SDKFont*) zenfolioLabelFont {
    return [SDKFont boldZenfolioFontOfSize:[SDKFont systemFontSize]];
}

#endif
@end
