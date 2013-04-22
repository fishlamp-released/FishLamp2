//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringAddKeyPlainResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFKeyringAddKeyPlainResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFKeyringAddKeyPlainResponse


@synthesize KeyringAddKeyPlainResult = _KeyringAddKeyPlainResult;

+ (NSString*) KeyringAddKeyPlainResultKey
{
	return @"KeyringAddKeyPlainResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFKeyringAddKeyPlainResponse*)object).KeyringAddKeyPlainResult = FLCopyOrRetainObject(_KeyringAddKeyPlainResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_KeyringAddKeyPlainResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_KeyringAddKeyPlainResult) [aCoder encodeObject:_KeyringAddKeyPlainResult forKey:@"_KeyringAddKeyPlainResult"];
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
		_KeyringAddKeyPlainResult = FLRetain([aDecoder decodeObjectForKey:@"_KeyringAddKeyPlainResult"]);
	}
	return self;
}

+ (ZFKeyringAddKeyPlainResponse*) keyringAddKeyPlainResponse
{
	return FLAutorelease([[ZFKeyringAddKeyPlainResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"KeyringAddKeyPlainResult" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"KeyringAddKeyPlainResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFKeyringAddKeyPlainResponse (ValueProperties) 
@end

