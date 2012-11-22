//
//	FLFunctor.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFunctor.h"

@implementation FLFunctor

- (id) init
{
	if((self = [super initWithTarget:self action:@selector(doPerformCallback:)]))
	{
	}
	
	return self;
}

- (void) doPerformCallback:(id) sender
{

}

@end