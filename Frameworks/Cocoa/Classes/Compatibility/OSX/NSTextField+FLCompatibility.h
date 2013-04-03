//
//  UITextField.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import <Cocoa/Cocoa.h>
#import <AppKit/AppKit.h>


@interface NSTextField (FLCompatibility)
@property (readwrite, strong, nonatomic) NSString* text;
@end

#endif

