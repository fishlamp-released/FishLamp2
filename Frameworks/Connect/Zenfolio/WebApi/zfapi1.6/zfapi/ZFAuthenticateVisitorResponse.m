//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateVisitorResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAuthenticateVisitorResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAuthenticateVisitorResponse


@synthesize AuthenticateVisitorResult = _AuthenticateVisitorResult;

+ (NSString*) AuthenticateVisitorResultKey
{
	return @"AuthenticateVisitorResult";
}

+ (ZFAuthenticateVisitorResponse*) authenticateVisitorResponse
{
	return FLAutorelease([[ZFAuthenticateVisitorResponse alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAuthenticateVisitorResponse*)object).AuthenticateVisitorResult = FLCopyOrRetainObject(_AuthenticateVisitorResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_AuthenticateVisitorResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_AuthenticateVisitorResult) [aCoder encodeObject:_AuthenticateVisitorResult forKey:@"_AuthenticateVisitorResult"];
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
		_AuthenticateVisitorResult = FLRetain([aDecoder decodeObjectForKey:@"_AuthenticateVisitorResult"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"AuthenticateVisitorResult" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AuthenticateVisitorResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthenticateVisitorResponse (ValueProperties) 
@end

