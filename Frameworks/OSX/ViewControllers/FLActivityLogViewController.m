//
//  ZFActivityLogView.m
//  ZenfolioDownloader
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLActivityLogViewController.h"
#import "FLAttributedString.h"

@implementation FLActivityLogViewController

@synthesize activityLog = _activityLog;

- (id) initActivityLogView {
    _textView.drawsBackground = NO;
    [_textView setAlignment:NSLeftTextAlignment];
    [_textView setRichText:YES];
    [[_textView textContainer] setContainerSize:NSMakeSize(FLT_MAX, FLT_MAX)];
    [[_textView textContainer] setWidthTracksTextView:NO];
    [_textView setHorizontallyResizable:YES];
    [_textView setTextContainerInset:NSMakeSize(10, 10)];
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

#if FL_MRC
    [_activityLog release];
    [super dealloc];
#endif
}

//- (void) setTextColor:(NSColor*) color {
//    FLSetObjectWithRetain(_color, color);
//    [self setTextColor:[NSColor darkGrayColor]];
//}

//- (void) setFont:(NSFont*) font {
//    FLSetObjectWithRetain(_textFont, font);
//    [self setFont:self.textFont];
//    [[self textStorage] setFont:self.textFont];
//}


- (void) logWasUpdated:(NSNotification*) note {
    NSAttributedString* string = [[note userInfo] objectForKey:FLActivityLogStringKey];
    if(string) {
        [self appendAttributedString:string];
    }
}

- (void) setActivityLog:(FLActivityLog*) log {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    FLSetObjectWithRetain(_activityLog, log);
    [[NSNotificationCenter defaultCenter] addObserver:self  
                                             selector:@selector(logWasUpdated:) 
                                                 name:FLActivityLogUpdated 
                                               object:[self activityLog]];

    [self clearContents];
}

//- (id) initWithFrame:(CGRect) frame {
//    return [[self initWithFrame:frame] initActivityLogView];
//}
//
//- (id)initWithCoder:(NSCoder *)aDecoder {
//    return [[self initWithCoder:aDecoder] initActivityLogView];
//}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self initActivityLogView];
    
    [_textView setEnabledTextCheckingTypes:NSTextCheckingTypeLink];
}

- (void) appendAttributedString:(NSAttributedString*) string {
//    NSMutableAttributedString* mutableString = FLMutableCopyWithAutorelease(string);
//    [mutableString setFont:_textView.font forRange:string.entireRange];
    dispatch_async(dispatch_get_main_queue(), ^{
    if(string) {
//        [[_textView textStorage] beginEditing];
        [[_textView textStorage] appendAttributedString:string];
//        [[_textView textStorage] endEditing];
        
//        NSRange range = NSMakeRange ([[_textView string] length], 0);
//        [_textView scrollRangeToVisible: range];
        
  // Scroll the vertical scroller to top
        if ([_scrollView hasVerticalScroller]) {
            _scrollView.verticalScroller.floatValue = 0;
        }

        // Scroll the contentView to top
        [_scrollView.contentView scrollToPoint:NSMakePoint(0, ((NSView*)_scrollView.documentView).frame.size.height - _scrollView.contentSize.height)];        
        
//        [_textView setNeedsDisplay];
    }
    });
}


- (void) clearContents {
    [[_textView textStorage] deleteCharactersInRange:NSMakeRange(0, [_textView textStorage].length) ];
    [self appendAttributedString:[self activityLog].attributedString];
}

@end
