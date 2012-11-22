//
//  FLTwitterUserHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLUserHeaderView.h"
#import "FLAction.h"

@interface FLTwitterUserHeaderView : FLUserHeaderView {
@private
	NSString* _userGuid;
}

@property (readwrite, retain, nonatomic) NSString* userGuid;

- (void) startLoadingInViewController:(UIViewController*) viewController userGuid:(NSString*) userGuid;

@end
