//
//  FLCodeLine.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeLine.h"

@implementation FLCodeLine
@synthesize codeLineType = _codeLineType;
@synthesize parameters = _parameters;

- (id) initWithCodeLineType:(FLCodeLineType) codeLineType {	
	self = [super init];
	if(self) {
		_codeLineType = codeLineType;
        _parameters = [[NSMutableDictionary alloc] init];
	}
	return self;
}

+ (id) codeLine:(FLCodeLineType) codeLineType {
    return FLAutorelease([[[self class] alloc] initWithCodeLineType:codeLineType]);
}

#if FL_MRC
- (void) dealloc {
	[_parameters release];
	[super dealloc];
}
#endif

- (void) addParameter:(id) param forKey:(id) key {
    [_parameters setObject:param forKey:key];
}

- (id) parameterForKey:(id) key {
    return [_parameters objectForKey:key];
}

+ (id) codeLineReturnString:(NSString*) string {
    FLCodeLine* codeLine = [FLCodeLine codeLine:FLCodeLineTypeReturnString];
    [codeLine addParameter:string forKey:FLCodeLineString];
    return codeLine;
}

+ (id) codeLineReturnNewObject:(NSString*) objectClass {
    FLCodeLine* codeLine = [FLCodeLine codeLine:FLCodeLineTypeReturnNewObject];
    [codeLine addParameter:objectClass forKey:FLCodeLineClassName];
    return codeLine;
}


@end
