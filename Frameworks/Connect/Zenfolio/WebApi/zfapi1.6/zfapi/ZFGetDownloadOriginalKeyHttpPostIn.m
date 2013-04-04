//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetDownloadOriginalKeyHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetDownloadOriginalKeyHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetDownloadOriginalKeyHttpPostIn


@synthesize password = _password;
@synthesize photoIds = _photoIds;

+ (NSString*) passwordKey
{
	return @"password";
}

+ (NSString*) photoIdsKey
{
	return @"photoIds";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetDownloadOriginalKeyHttpPostIn*)object).photoIds = FLCopyOrRetainObject(_photoIds);
	((ZFGetDownloadOriginalKeyHttpPostIn*)object).password = FLCopyOrRetainObject(_password);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoIds);
	FLRelease(_password);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoIds) [aCoder encodeObject:_photoIds forKey:@"_photoIds"];
	if(_password) [aCoder encodeObject:_password forKey:@"_password"];
}

+ (ZFGetDownloadOriginalKeyHttpPostIn*) getDownloadOriginalKeyHttpPostIn
{
	return FLAutorelease([[ZFGetDownloadOriginalKeyHttpPostIn alloc] init]);
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
		_photoIds = [[aDecoder decodeObjectForKey:@"_photoIds"] mutableCopy];
		_password = FLRetain([aDecoder decodeObjectForKey:@"_password"]);
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
		[s_describer addChildDescriberWithName:@"photoIds" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"String" objectClass:[NSString class] ], nil]];
		[s_describer addChildDescriberWithName:@"password" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoIds" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetDownloadOriginalKeyHttpPostIn (ValueProperties) 
@end

