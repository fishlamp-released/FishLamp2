//
//  FLToolbarTitleView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLToolbarTitleView.h"

@implementation FLToolbarTitleView

@synthesize textLabel = _textLabel;

- (id) init {
    if((self = [super init])) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectZero]; 
        _textLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        _textLabel.backgroundColor = [SDKColor clearColor];
        _textLabel.textColor = [SDKColor whiteColor];
        self.view = _textLabel;
    }
    
    return self;
}

- (void) dealloc {
    FLRelease(_textLabel);
    super_dealloc_();
}

- (void) setGrayText {
    self.textLabel.textColor = [SDKColor gray10Color];
    self.textLabel.shadowColor = [SDKColor whiteColor];
    self.textLabel.shadowOffset = FLSizeMake(0,1);
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