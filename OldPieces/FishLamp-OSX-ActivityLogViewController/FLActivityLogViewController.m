//
//  ZFActivityLogView.m
//  FishLamp
//
//  Created by Mike Fullerton on 3/11/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLActivityLogViewController.h"
#import "FLTextViewLogger.h"

@implementation FLActivityLogViewController

@synthesize activityLog = _activityLog;

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

#if FL_MRC
    [_activityLog release];
    [super dealloc];
#endif
}

- (void) logWasUpdated:(NSNotification*) note {
    NSAttributedString* string = [[note userInfo] objectForKey:FLActivityLogStringKey];
    if(string) {
        [self.logger appendAttributedString:string];
    }
}

- (void) setActivityLog:(FLActivityLog*) log {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    FLSetObjectWithRetain(_activityLog, log);
    [[NSNotificationCenter defaultCenter] addObserver:self  
                                             selector:@selector(logWasUpdated:) 
                                                 name:FLActivityLogUpdated 
                                               object:[self activityLog]];

    [self.logger clearContents];

    // don't think we need this...???
    [self setLinkAttributes];
}

- (void) awakeFromNib {
    [super awakeFromNib];
    [self.textView setEditable:NO];
}

@end
