//
//  FLFacebookEditMessageViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFacebookEditMessageViewController.h"

#import "FLFacebookLoadUserOperation.h"
#import "FLFacebookLoadUserPictureOperation.h"
#import "FLFacebookMgr.h"
#import "FLCachedImage.h"

@implementation FLFacebookEditMessageViewController

+ (FLFacebookEditMessageViewController*) facebookEditMessageViewController
{
	return FLAutorelease([[FLFacebookEditMessageViewController alloc] init]);
}



@end
