//
//  FLFacebookEditMessageViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookEditMessageViewController.h"

#import "FLFacebookLoadUserOperation.h"
#import "FLFacebookLoadUserPictureOperation.h"
#import "FLFacebookMgr.h"
#import "FLCachedImage.h"

@implementation FLFacebookEditMessageViewController

+ (FLFacebookEditMessageViewController*) facebookEditMessageViewController
{
	return autorelease_([[FLFacebookEditMessageViewController alloc] init]);
}



@end
