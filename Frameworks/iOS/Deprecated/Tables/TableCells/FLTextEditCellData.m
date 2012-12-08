//
//	FLTextEditCellData.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/31/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTextEditCellData.h"


@implementation FLTextEditCellData

@synthesize textInputTraits = _traits;
@synthesize callback = _callback;

- (void) dealloc
{
	FLRelease(_callback);
	FLRelease(_traits);
	super_dealloc_();
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
