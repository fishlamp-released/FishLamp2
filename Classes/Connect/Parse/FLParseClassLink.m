//
//  FLParseClassLink.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 5/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParseClassLink.h"

@interface FLParseClassLink ()
@end

@implementation FLParseClassLink
@synthesize objectClass = _objectClass;
@synthesize objectId = _objectId;

- (id) initWithClassName:(NSString*) className objectId:(NSString*) objectId {	
	self = [super init];
	if(self) {
        _objectClass = className;
        _objectId = [objectId copy];
    }
	return self;
}

#if FL_MRC
- (void) dealloc {
	[_objectClass release];
	[_objectId release];
	[super dealloc];
}
#endif

#define kPrefix @"fl_"

+ (id) parseClassLink:(NSString*) encoded {
    
    if(![encoded hasPrefix:kPrefix]) {
        return nil;
    }
    
    NSRange delim = [encoded rangeOfString:@":"];
    if(delim.length == 0) {
        return nil;
    }
    
    NSString* className = [encoded substringWithRange:NSMakeRange(kPrefix.length, delim.location - kPrefix.length)];
    if(FLStringIsEmpty(className)) {
        return nil;
    }
    
    NSString* objectId = [encoded substringFromIndex:delim.location + 1];
    if(FLStringIsEmpty(objectId)) {
        return nil;
    }
    
    return FLAutorelease([[[self class] alloc] initWithClassName:className objectId:objectId]);
}

+ (id) parseClassLink:(Class) aClass objectId:(NSString*) objectId {
    return FLAutorelease([[[self class] alloc] initWithClassName:NSStringFromClass(aClass) objectId:objectId]);
}

- (NSString*) encodedString {
    return [NSString stringWithFormat:@"%@%@:%@", kPrefix, _objectClass, _objectId];
}

- (NSString*) description {
    return self.encodedString;
}   

@end
