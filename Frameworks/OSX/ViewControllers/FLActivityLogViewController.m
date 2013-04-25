//
//  ZFActivityLogView.m
//  FishLamp
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLActivityLogViewController.h"
#import "FLAttributedString.h"

@interface FLActivityLogViewController()
@property (readwrite, nonatomic, strong) NSMutableAttributedString* buffer;
@end

@implementation FLActivityLogViewController

@synthesize activityLog = _activityLog;
@synthesize buffer = _buffer;

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

#if FL_MRC
    [_buffer release];
    [_activityLog release];
    [super dealloc];
#endif
}

- (void) logWasUpdated:(NSNotification*) note {
    NSAttributedString* string = [[note userInfo] objectForKey:FLActivityLogStringKey];
    if(string) {
        [self appendAttributedString:string];
    }
}

//- (void)scrollToBottom
//{
//    NSPoint     pt;
//    id          scrollView;
//    id          clipView;
//
//    pt.x = 0;
//    pt.y = 100000000000.0;
//
//    scrollView = [self enclosingScrollView];
//    clipView = [scrollView contentView];
//
//    pt = [clipView constrainScrollPoint:pt];
//    [clipView scrollToPoint:pt];
//    [scrollView reflectScrolledClipView:clipView];
//}

//- (void) scrollToBottom {
//// Scroll the vertical scroller to top
//
//    
//
////    if ([_scrollView hasVerticalScroller]) {
////        _scrollView.verticalScroller.floatValue = 0;
////    }
////
////    // Scroll the contentView to top
////    [_scrollView.contentView scrollToPoint:NSMakePoint(0, ((NSView*)_scrollView.documentView).frame.size.height - _scrollView.contentSize.height)];        
//
//
//
//
//    [_textView scrollRangeToVisible:range];
//}

- (void) setActivityLog:(FLActivityLog*) log {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    FLSetObjectWithRetain(_activityLog, log);
    [[NSNotificationCenter defaultCenter] addObserver:self  
                                             selector:@selector(logWasUpdated:) 
                                                 name:FLActivityLogUpdated 
                                               object:[self activityLog]];

    [self clearContents];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    _lastUpdate = 0;
    _textView.drawsBackground = NO;
    [_textView setAlignment:NSLeftTextAlignment];
    [_textView setRichText:YES];
    [[_textView textContainer] setContainerSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [[_textView textContainer] setWidthTracksTextView:NO];
    [_textView setHorizontallyResizable:YES];
    [_textView setTextContainerInset:NSMakeSize(10, 10)];
    
    [_textView setEnabledTextCheckingTypes:NSTextCheckingTypeLink];
}

#define kDelay 0.5

- (void) appendBufferToTextStorage {
    if(!_buffer) {
        return;
    }

    if([NSDate timeIntervalSinceReferenceDate] - _lastUpdate > kDelay) {
        NSTextStorage* textStorage = [_textView textStorage];
        NSRange range = NSMakeRange(textStorage.length, 0);
        
        float scrollBottom = NSMaxY(_textView.visibleRect);
        float contentHeight = NSMaxY(_textView.bounds);
        
        BOOL scroll = (contentHeight - scrollBottom) > 20.0f;
        
        [textStorage beginEditing];
        [textStorage replaceCharactersInRange:range withAttributedString:_buffer];
//        [textStorage appendAttributedString:_buffer];
        [textStorage endEditing];
        
        self.buffer = nil;
        _lastUpdate = [NSDate timeIntervalSinceReferenceDate];
    
        if(scroll) {
            [_textView scrollRangeToVisible:NSMakeRange(textStorage.length, 0)];
        }
    }
    else {
        double delayInSeconds = kDelay;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(){
            [self appendBufferToTextStorage];
        });
    }
}

- (void) appendAttributedString:(NSAttributedString*) string {

    if(_buffer) {
        [_buffer appendAttributedString:string];
    }
    else {
        _buffer = [string mutableCopy];
    }

    [self appendBufferToTextStorage];
}


- (void) clearContents {
    [[_textView textStorage] deleteCharactersInRange:NSMakeRange(0, [_textView textStorage].length) ];
    [self appendAttributedString:[self activityLog].attributedString];
}

@end
