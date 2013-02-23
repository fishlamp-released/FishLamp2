//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthenticateVisitor.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioAuthenticateVisitor.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioAuthenticateVisitor


@synthesize visitorKey = _visitorKey;

+ (NSString*) visitorKeyKey
{
	return @"visitorKey";
}

+ (FLZenfolioAuthenticateVisitor*) authenticateVisitor
{
	return FLAutorelease([[FLZenfolioAuthenticateVisitor alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioAuthenticateVisitor*)object).visitorKey = FLCopyOrRetainObject(_visitorKey);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_visitorKey);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_visitorKey) [aCoder encodeObject:_visitorKey forKey:@"_visitorKey"];
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
		_visitorKey = FLRetain([aDecoder decodeObjectForKey:@"_visitorKey"]);
	}
	return self;
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"visitorKey" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"visitorKey"];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"visitorKey" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioAuthenticateVisitor (ValueProperties) 
@end
