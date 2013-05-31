//
//  FLTwitterUserHeaderView.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/8/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
