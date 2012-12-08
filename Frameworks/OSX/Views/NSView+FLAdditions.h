//
//  NSView+FLAdditions.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSView (FLAdditions)
- (void) sendToBack;
- (void) addBackgroundView:(NSView*) view;
@end