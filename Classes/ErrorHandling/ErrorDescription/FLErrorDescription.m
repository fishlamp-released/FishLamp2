//
//	FLErrorDescription.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLErrorDescription.h"


@implementation FLErrorDescription

@synthesize title = _title;
@synthesize description = _description;
@synthesize error = _error;

- (id) initWithTitle:(NSString*) title description:(NSString*) description
{
	if((self = [super init]))
	{
		self.title = title;
		self.description = description;
	}
	return self;
}

+ (FLErrorDescription*) errorDescription
{
	
    return autorelease_([[FLErrorDescription alloc] init]);
}
+ (FLErrorDescription*) errorDescriptionWithTitle:(NSString*) title description:(NSString*) description
{
	return autorelease_([[FLErrorDescription alloc] initWithTitle:title description:description]);
}

- (void) dealloc
{
	mrc_release_(_error);
	mrc_release_(_title);
	mrc_release_(_description);
	super_dealloc_();
}

@end