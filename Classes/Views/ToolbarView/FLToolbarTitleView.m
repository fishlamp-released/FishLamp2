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
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor whiteColor];
        self.view = _textLabel;
    }
    
    return self;
}

- (void) dealloc {
    mrc_release_(_textLabel);
    mrc_super_dealloc_();
}

- (void) setGrayText {
    self.textLabel.textColor = [UIColor gray10Color];
    self.textLabel.shadowColor = [UIColor whiteColor];
    self.textLabel.shadowOffset = FLSizeMake(0,1);
}

+ (FLToolbarTitleView*) toolbarTitleView {
    return autorelease_([[FLToolbarTitleView alloc] init]);
}

- (void) setSubviewSize:(FLSize) size {
    _textLabel.frame = FLRectSetSizeWithSize(_textLabel.frame, size);
}

- (FLSize) subviewSizeThatFitsInBounds:(FLRect) bounds {
    return [_textLabel sizeThatFitsText];
}

- (void) toolbarTitleDidChange:(NSString*) title {
    [self.view setText:title];
}


@end