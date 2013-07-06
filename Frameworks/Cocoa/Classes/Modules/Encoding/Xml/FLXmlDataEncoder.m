//
//  FLXmlDataEncoder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLXmlDataEncoder.h"
#import "FLXmlStringEncoding.h"

@implementation FLXmlDataEncoder

FLSynthesizeSingleton(FLXmlDataEncoder)

- (id) init {	
	self = [super init];
	if(self) {
		[self addStringEncoder:[FLXmlStringEncoder xmlStringEncoder]];
		[self addStringEncoder:[FLXmlURLStringEncoder xmlURLStringEncoder]];
	}
	return self;
}

@end
