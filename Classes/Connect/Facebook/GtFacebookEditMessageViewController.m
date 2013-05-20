//
//  GtFacebookEditMessageViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookEditMessageViewController.h"

#import "GtFacebookLoadUserOperation.h"
#import "GtFacebookLoadUserPictureOperation.h"
#import "GtFacebookMgr.h"
#import "GtCachedImage.h"

@implementation GtFacebookEditMessageViewController

+ (GtFacebookEditMessageViewController*) facebookEditMessageViewController
{
	return GtReturnAutoreleased([[GtFacebookEditMessageViewController alloc] init]);
}



@end
