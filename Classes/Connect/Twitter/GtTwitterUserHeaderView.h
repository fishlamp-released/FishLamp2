//
//  GtTwitterUserHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtUserHeaderView.h"
#import "GtAction.h"
#import "GtActionContext.h"

@interface GtTwitterUserHeaderView : GtUserHeaderView {
@private
	NSString* m_userGuid;
}

@property (readwrite, retain, nonatomic) NSString* userGuid;

- (void) beginLoadingInActionContext:(GtActionContext*) actionContext userGuid:(NSString*) userGuid;

@end
