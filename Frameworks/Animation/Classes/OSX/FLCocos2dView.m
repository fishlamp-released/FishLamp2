//
//  FLCocos2dViw.m
//  FishLampAnimation
//
//  Created by Mike Fullerton on 4/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocos2dView.h"

@implementation FLCocos2dView 
@synthesize delegate = _delegate;

- (void) viewDidMoveToWindow {
    [super viewDidMoveToWindow];
    [_delegate cocos2dViewDidMoveToWindow:self];
}



@end
