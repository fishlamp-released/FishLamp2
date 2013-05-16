//
//  GtWsdlAction.m
//  seemeBaseball
//
//  Created by Mike Fullerton on 2/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GtWsdlAction.h"


@implementation GtWsdlAction

- (void) begin:(id) delegate
    superview:(UIView*) superview
    busyText:(NSString*) busyText
{
    [self setCompletedCallback:delegate selector:@selector(onWsdlActionCompleted:)];
    self.progress.text = busyText;
    self.progress.superview = superview;
    [self beginAction];
}

- (void) setProgressInfo:(NSString*) busyText 
                 isModal:(BOOL) isModal
{
    self.progress.text = busyText;
    self.progress.isModal = isModal;
}


@end
