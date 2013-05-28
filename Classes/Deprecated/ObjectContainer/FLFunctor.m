//
//	FLFunctor.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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