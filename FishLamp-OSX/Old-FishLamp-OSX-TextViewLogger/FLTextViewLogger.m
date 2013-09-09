//
//  FLTextViewLogger.m
//  FishLampOSX
//
//  Created by Mike Fullerton on 6/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTextViewLogger.h"

@interface FLTextViewLogger()
@property (readwrite, nonatomic, strong) NSMutableAttributedString* buffer;
- (void) appendBufferToTextStorage;
@end

@implementation FLTextViewLogger

@synthesize buffer = _buffer;
@synthesize textView = _textView;

- (id) initWithTextView:(NSTextView*) textView {
	self = [super init];
	if(self) {
		self.textView = textView;
	}
	return self;
}

+ (id) textViewLogger:(NSTextView*) textView {
    return FLAutorelease([[[self class] alloc] initWithTextView:textView]);
}

+ (id) textViewLogger {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void)dealloc {
    [_textView release];
    [_buffer release];
	[super dealloc];
}
#endif

#define kDelay 0.25

- (void) update {
    [FLForegroundQueue queueBlockWithDelay:kDelay
                                      block:^{
                                          [self appendBufferToTextStorage];
                                      }];
}

- (void) appendBufferToTextStorage {
    if(!_buffer) {
        return;
    }

    NSTextStorage* textStorage = [_textView textStorage];
    NSRange range = NSMakeRange(textStorage.length, 0);
    
    float scrollBottom = NSMaxY(_textView.visibleRect);
    float contentHeight = NSMaxY(_textView.bounds);
    
    BOOL scroll = (contentHeight == scrollBottom);
    [textStorage beginEditing];
    [textStorage replaceCharactersInRange:range withAttributedString:_buffer];
    [textStorage endEditing];
    
    self.buffer = nil;
    _lastUpdate = [NSDate timeIntervalSinceReferenceDate];

    if(scroll && contentHeight > scrollBottom) {
//            [_textView scrollRangeToVisible:NSMakeRange(textStorage.length, 0)];
    }

    [self update];
}

- (void) willAppendAttributedString:(NSAttributedString*) string {

    if(_buffer) {
        [_buffer appendAttributedString:string];
    }
    else {
        _buffer = [string mutableCopy];
        [self update];
    }
}

- (void) willAppendString:(NSString*) string {
    NSAttributedString* attrstring = FLAutorelease([[NSAttributedString alloc] initWithString:string]);
    [self willAppendAttributedString:attrstring];
}

- (void) clearContents {
    [[_textView textStorage] deleteCharactersInRange:NSMakeRange(0, [_textView textStorage].length) ];
    self.buffer = nil;
}

- (NSUInteger) length {
    return [_textView textStorage].length + _buffer.length;
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter
appendSelfToStringFormatter:(id<FLStringFormatter>) anotherStringFormatter {

}

@end

