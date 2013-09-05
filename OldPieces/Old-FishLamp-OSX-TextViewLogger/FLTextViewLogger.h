//
//  FLTextViewLogger.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 6/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"
#import "FLWhitespaceStringFormatter.h"

@interface FLTextViewLogger : FLWhitespaceStringFormatter {
@private
    NSTextView* _textView;
    NSMutableAttributedString* _buffer;
    NSTimeInterval _lastUpdate;
}

@property (readwrite, strong, nonatomic) NSTextView* textView;

- (id) initWithTextView:(NSTextView*) textView;
+ (id) textViewLogger:(NSTextView*) textView;

- (void) clearContents;

@end
