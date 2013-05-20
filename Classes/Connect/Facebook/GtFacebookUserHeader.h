//
//  GtFacebookUserHeader.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtUserHeaderView.h"
#import "GtAction.h"
#import "GtActionContext.h"

@interface GtFacebookUserHeader : GtUserHeaderView {
}

- (void) beginLoadingInActionContext:(GtActionContext*) actionContext;

@end
