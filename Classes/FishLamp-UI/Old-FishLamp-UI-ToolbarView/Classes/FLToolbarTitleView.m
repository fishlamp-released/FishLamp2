//
//  FLToolbarTitleView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLToolbarTitleView.h"
#import "SDKColor+FLMoreColors.h"
#import "SDKLabel+FLExtras.h"

@implementation FLToolbarTitleView

@synthesize textLabel = _textLabel;

- (id) init {
    if((self = [super init])) {
        _textLabel = [[SDKLabel alloc] initWithFrame:CGRectZero]; 
        _textLabel.font = [SDKFont boldSystemFontOfSize:[SDKFont systemFontSize]];
        _textLabel.backgroundColor = [SDKColor clearColor];
        _textLabel.textColor = [SDKColor whiteColor];
        self.view = _textLabel;
    }
    
    return self;
}

- (void) dealloc {
    FLRelease(_textLabel);
    FLSuperDealloc();
}

- (void) setGrayText {
    self.textLabel.textColor = [SDKColor gray10Color];
#if IOS
    self.textLabel.shadowColor = [SDKColor whiteColor];
    self.textLabel.shadowOffset = CGSizeMake(0,1);
#endif
}

+ (FLToolbarTitleView*) toolbarTitleView {
    return FLAutorelease([[FLToolbarTitleView alloc] init]);
}

- (void) setSubviewSize:(CGSize) size {
    _textLabel.frame = FLRectSetSizeWithSize(_textLabel.frame, size);
}

- (CGSize) subviewSizeThatFitsInBounds:(CGRect) bounds {
    return [_textLabel sizeThatFitsText];
}

- (void) toolbarTitleDidChange:(NSString*) title {
    [self.view setText:title];
}


@end