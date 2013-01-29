//
//  ZFErrorSheet.h
//  ZenLib
//
//  Created by Mike Fullerton on 1/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ZFErrorSheet : NSWindowController {
@private
    IBOutlet NSTextField* _textField;
    dispatch_block_t _completion;
}

+ (id) errorSheet;

- (void) setErrorString:(NSString*) error;

- (void) showInWindow:(NSWindow*) window completion:(void (^)()) completion;

@end
