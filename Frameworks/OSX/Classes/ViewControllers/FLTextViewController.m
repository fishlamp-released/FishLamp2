//
//  FLTextViewController.m
//  PackMule
//
//  Created by Mike Fullerton on 6/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTextViewController.h"
#import "FLTextViewLogger.h"

@implementation FLTextViewController

@synthesize textView = _textView;
@synthesize logger = _logger;
FLSynthesizeLazyGetterWithInit(logger, FLTextViewLogger*, _logger, [[FLTextViewLogger alloc] initWithTextView:self.textView]);

- (void) setLinkAttributes {
    NSMutableDictionary* attr = [NSMutableDictionary dictionary];
    [attr setObject:[NSFont boldSystemFontOfSize:[NSFont smallSystemFontSize]] forKey:NSFontAttributeName];
    [attr setObject:[NSNumber numberWithBool:YES] forKey:NSUnderlineStyleAttributeName];
    [attr setObject:[NSColor blueColor] forKey:NSForegroundColorAttributeName];
    [attr setObject:[NSCursor pointingHandCursor] forKey:NSCursorAttributeName];
    [_textView setLinkTextAttributes:attr];
}

- (void) awakeFromNib {
	[super awakeFromNib];
    FLAssertNotNil(_textView);
}

#if FL_MRC
- (void)dealloc {
	[_logger release];
	[super dealloc];
}
#endif

@end


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