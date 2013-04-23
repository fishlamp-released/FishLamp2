//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAuthenticateHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAuthenticateHttpGetIn


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

+ (ZFAuthenticateHttpGetIn*) authenticateHttpGetIn
{
	return FLAutorelease([[ZFAuthenticateHttpGetIn alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAuthenticateHttpGetIn*)object).challenge = FLCopyOrRetainObject(_challenge);
	((ZFAuthenticateHttpGetIn*)object).proof = FLCopyOrRetainObject(_proof);
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
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"challenge" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"String" class:[NSString class] ], nil]];
		[describer setChildForIdentifier:@"proof" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"String" class:[NSString class] ], nil]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"challenge" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"proof" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthenticateHttpGetIn (ValueProperties) 
@end

