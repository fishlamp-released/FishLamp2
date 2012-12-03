//
//	FLDataParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/6/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCore.h"

@protocol FLDataParser
- (void) parse:(NSData*) data;
@end