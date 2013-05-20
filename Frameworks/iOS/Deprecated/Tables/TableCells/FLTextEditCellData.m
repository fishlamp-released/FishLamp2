//
//	FLTextEditCellData.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/31/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTextEditCellData.h"


@implementation FLTextEditCellData

@synthesize textInputTraits = _traits;
@synthesize callback = _callback;

- (void) dealloc
{
	FLRelease(_callback);
	FLRelease(_traits);
	FLSuperDealloc();
}

- (id) init
{
	if((self = [super init]))
	{
		_traits = [[FLTextInputTraits alloc] init];
	}
	return self;
}

+ (FLTextEditCellData*) textEditCellData
{
	return FLAutorelease([[FLTextEditCellData alloc] init]);
}



@end

