//
//  FLCodeLine.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeLine.h"

@implementation FLCodeLine

@synthesize codeLine = _codeLine;

#if FL_MRC
- (void) dealloc {
	[_codeLine release];
	[super dealloc];
}
#endif

- (id) initWithCodeLine:(id) codeLine {	
	self = [super init];
	if(self) {
		self.codeLine = codeLine;
	}
	return self;
}


@end
