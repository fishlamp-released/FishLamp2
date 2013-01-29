//
//  ZFLinkTextField.h
//  ZenfolioDownloader
//
//  Created by patrick machielse on 28-7-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSFont+ZFAdditions.h"
#import "ZFTextField.h"

@interface ZFLinkTextField : ZFTextField {
@private
	BOOL _underline;
    BOOL _mouseDown;
    BOOL _mouseIn;
    NSColor* _color;
    NSTrackingRectTag _boundsTrackingTag;
}

@end
