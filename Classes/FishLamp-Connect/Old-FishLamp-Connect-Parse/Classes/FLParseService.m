//
//  FLParseService.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 5/21/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParseService.h"
#import "FLParseServiceStorage.h"
//#import <ParseOSX/Parse.h>

@implementation FLParseService

+ (id) parseService {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {	
	self = [super init];
	if(self) {
		
	}
	return self;
}

@end
