//
//  FLCodeMethod+Additions.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeMethod+Additions.h"
#import "FLCodeObjectModel.h"

@implementation FLCodeMethod (Additions)

- (BOOL) hasLines {
	return self.code.lines.length > 0;
}

@end
