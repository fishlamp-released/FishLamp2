//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFResolveReferenceResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFResolveReferenceResponse.h"
#import "ZFResolveResult.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFResolveReferenceResponse


@synthesize ResolveReferenceResult = _ResolveReferenceResult;

+ (NSString*) ResolveReferenceResultKey
{
	return @"ResolveReferenceResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFResolveReferenceResponse*)object).ResolveReferenceResult = FLCopyOrRetainObject(_ResolveReferenceResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_ResolveReferenceResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_ResolveReferenceResult) [aCoder encodeObject:_ResolveReferenceResult forKey:@"_ResolveReferenceResult"];
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
		_ResolveReferenceResult = FLRetain([aDecoder decodeObjectForKey:@"_ResolveReferenceResult"]);
	}
	return self;
}

+ (ZFResolveReferenceResponse*) resolveReferenceResponse
{
	return FLAutorelease([[ZFResolveReferenceResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"ResolveReferenceResult" withClass:[ZFResolveResult class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ResolveReferenceResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFResolveReferenceResponse (ValueProperties) 
@end

