//
//	FLDataParser.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/6/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

@protocol FLDataParser
- (void) parse:(NSData*) data;
@end