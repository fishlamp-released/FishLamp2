//
//	GtGuid.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGuid.h"
#import "NSString+GUID.h"

@implementation GtGuid

@synthesize guidString = _guid;

static GtGuid* s_emptyGuid = nil;

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
	s_emptyGuid = [[GtGuid alloc] initWithGuidString:[NSString zeroGuidString]];
}

+ (GtGuid*) guid { 	
    return GtReturnAutoreleased([[GtGuid alloc] init]);
}

+ (GtGuid*) guidWithNewGuid {
	return GtReturnAutoreleased([[GtGuid alloc] initWithNewGuid]);
}

+ (GtGuid*) guidWithString:(NSString*) aGuidString {
	return GtReturnAutoreleased([[GtGuid alloc] initWithGuidString:aGuidString]);
}

#if GT_DEALLOC
- (void) dealloc {
    [_guid release];
    [super dealloc];
}
#endif


+ (GtGuid*) emptyGuid {
	return s_emptyGuid;
}

- (id) copyWithZone:(NSZone *)zone {
	return [[GtGuid alloc] initWithGuidString:self.guidString];
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

- (BOOL)isEqualToGuid:(GtGuid*) aGuid {
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
	
	if([anObject isKindOfClass:[GtGuid class]]) {
		return [_guid isEqualToString:[anObject guidString]];
	}
	else if([anObject isKindOfClass:[NSString class]]) {
		return [_guid isEqualToString:anObject];
	}
	
	return NO;
}

+ (id) decodeObjectWithSqliteColumnString:(NSString*) string {
    return [GtGuid guidWithString:string];
}


@end
