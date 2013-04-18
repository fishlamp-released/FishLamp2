//
//  ZFActivityLogView.h
//  FishLamp
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLActivityLog.h"

@interface FLActivityLogViewController : NSViewController {
@private
    id<FLActivityLog> _activityLog;
    IBOutlet NSTextView* _textView;
    IBOutlet NSScrollView* _scrollView;
}

@property (readwrite, strong, nonatomic) id<FLActivityLog> activityLog;

- (void) clearContents;

- (void) appendAttributedString:(NSAttributedString*) string;

@end
