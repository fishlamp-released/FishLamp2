//
//	FLErrorDescription.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	
    return FLAutorelease([[FLErrorDescription alloc] init]);
}
+ (FLErrorDescription*) errorDescriptionWithTitle:(NSString*) title description:(NSString*) description
{
	return FLAutorelease([[FLErrorDescription alloc] initWithTitle:title description:description]);
}

- (void) dealloc
{
	FLRelease(_error);
	FLRelease(_title);
	FLRelease(_description);
	FLSuperDealloc();
}

@end