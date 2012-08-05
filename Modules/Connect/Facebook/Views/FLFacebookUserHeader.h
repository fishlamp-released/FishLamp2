//
//  FLFacebookUserHeader.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLUserHeaderView.h"
#import "FLAction.h"
#import "FLActionContext.h"

@interface FLFacebookUserHeader : FLUserHeaderView {
}

- (void) beginLoadingInActionContext:(FLActionContext*) actionContext;

@end
