//
//	FLGuid.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLGuid.h"
#import "NSString+GUID.h"

@implementation FLGuid

@synthesize guidString = _guid;

static FLGuid* s_emptyGuid = nil;

- (id) initWithGuidString:(NSString*) guid {
	if((self = [super init])) {
		self.guidString = guid;
	}
	
	return self;
}

- (id) init {
	if((self = [super init])) {
		self.guidString = s_emptyGuid.guidString;
	}
	
	return self;
}

+ (void) initialize {
	s_emptyGuid = [[FLGuid alloc] initWithGuidString:[NSString zeroGuidString]];
}

+ (FLGuid*) guid { 	
    return FLReturnAutoreleased([[FLGuid alloc] init]);
}

+ (FLGuid*) guidWithNewGuid {
	return FLReturnAutoreleased([[FLGuid alloc] initWithNewGuid]);
}

+ (FLGuid*) guidWithString:(NSString*) aGuidString {
	return FLReturnAutoreleased([[FLGuid alloc] initWithGuidString:aGuidString]);
}

#if FL_DEALLOC
- (void) dealloc {
    [_guid release];
    [super dealloc];
}
#endif


+ (FLGuid*) emptyGuid {
	return s_emptyGuid;
}

- (id) copyWithZone:(NSZone *)zone {
	return [[FLGuid alloc] initWithGuidString:self.guidString];
}

- (id) initWithNewGuid {
	if((self = [super init])) {
		self.guidString = [NSString guidString];
	}

	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if ((self = [super init]))  {
		self.guidString = [aDecoder decodeObjectForKey:@"guid"]; 
	}
	
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:_guid forKey:@"guid"];
}

- (BOOL)isEqualToString:(NSString*) aString {	
	return [_guid isEqualToString:aString];
}

- (BOOL)isEqualToGuid:(FLGuid*) aGuid {
	if(aGuid == self) {
		return YES;
	}

	return [_guid isEqualToString:aGuid.guidString];
}

- (NSString*) description {
	return self.guidString;
}

- (NSUInteger)hash {
	return _guid.hash;
}

- (BOOL)isEqual:(id)anObject {
	if(anObject == self) {
		return YES;
	}
	
	if([anObject isKindOfClass:[FLGuid class]]) {
		return [_guid isEqualToString:[anObject guidString]];
	}
	else if([anObject isKindOfClass:[NSString class]]) {
		return [_guid isEqualToString:anObject];
	}
	
	return NO;
}

+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return [FLGuid guidWithString:string];
}


@end
