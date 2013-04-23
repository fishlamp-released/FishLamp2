//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateVideoFromUrlResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreateVideoFromUrlResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreateVideoFromUrlResponse


@synthesize CreateVideoFromUrlResult = _CreateVideoFromUrlResult;

+ (NSString*) CreateVideoFromUrlResultKey
{
	return @"CreateVideoFromUrlResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCreateVideoFromUrlResponse*)object).CreateVideoFromUrlResult = FLCopyOrRetainObject(_CreateVideoFromUrlResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreateVideoFromUrlResponse*) createVideoFromUrlResponse
{
	return FLAutorelease([[ZFCreateVideoFromUrlResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreateVideoFromUrlResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreateVideoFromUrlResult) [aCoder encodeObject:_CreateVideoFromUrlResult forKey:@"_CreateVideoFromUrlResult"];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super init]))
	{
		_CreateVideoFromUrlResult = FLRetain([aDecoder decodeObjectForKey:@"_CreateVideoFromUrlResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"CreateVideoFromUrlResult" withClass:[FLIntegerNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreateVideoFromUrlResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreateVideoFromUrlResponse (ValueProperties) 

- (int) CreateVideoFromUrlResultValue
{
	return [self.CreateVideoFromUrlResult intValue];
}

- (void) setCreateVideoFromUrlResultValue:(int) value
{
	self.CreateVideoFromUrlResult = [NSNumber numberWithInt:value];
}
@end

