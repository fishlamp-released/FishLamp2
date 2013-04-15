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
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer setChildForIdentifier:@"AuthenticateVisitorResult" withClass:[NSString class]];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"AuthenticateVisitorResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthenticateVisitorResponse (ValueProperties) 
@end

