//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetChallengeResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetChallengeResponse.h"
#import "ZFAuthChallenge.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetChallengeResponse


@synthesize GetChallengeResult = _GetChallengeResult;

+ (NSString*) GetChallengeResultKey
{
	return @"GetChallengeResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetChallengeResponse*)object).GetChallengeResult = FLCopyOrRetainObject(_GetChallengeResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetChallengeResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetChallengeResult) [aCoder encodeObject:_GetChallengeResult forKey:@"_GetChallengeResult"];
}

+ (ZFGetChallengeResponse*) getChallengeResponse
{
	return FLAutorelease([[ZFGetChallengeResponse alloc] init]);
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
		_GetChallengeResult = FLRetain([aDecoder decodeObjectForKey:@"_GetChallengeResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"GetChallengeResult" withClass:[ZFAuthChallenge class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetChallengeResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetChallengeResponse (ValueProperties) 
@end

