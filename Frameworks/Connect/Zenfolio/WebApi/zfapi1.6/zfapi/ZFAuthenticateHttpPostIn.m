//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAuthenticateHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAuthenticateHttpPostIn


@synthesize challenge = _challenge;
@synthesize proof = _proof;

+ (NSString*) challengeKey
{
	return @"challenge";
}

+ (NSString*) proofKey
{
	return @"proof";
}

+ (ZFAuthenticateHttpPostIn*) authenticateHttpPostIn
{
	return FLAutorelease([[ZFAuthenticateHttpPostIn alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAuthenticateHttpPostIn*)object).challenge = FLCopyOrRetainObject(_challenge);
	((ZFAuthenticateHttpPostIn*)object).proof = FLCopyOrRetainObject(_proof);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_challenge);
	FLRelease(_proof);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_challenge) [aCoder encodeObject:_challenge forKey:@"_challenge"];
	if(_proof) [aCoder encodeObject:_proof forKey:@"_proof"];
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
		_challenge = [[aDecoder decodeObjectForKey:@"_challenge"] mutableCopy];
		_proof = [[aDecoder decodeObjectForKey:@"_proof"] mutableCopy];
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"challenge" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"String" class:[NSString class] ], nil]];
		[describer setChildForIdentifier:@"proof" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"String" class:[NSString class] ], nil]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"challenge" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"proof" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthenticateHttpPostIn (ValueProperties) 
@end

