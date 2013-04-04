//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMessageUpdater.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFMessageUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFMessageUpdater


@synthesize Body = _Body;
@synthesize IsPrivate = _IsPrivate;
@synthesize PosterEmail = _PosterEmail;
@synthesize PosterName = _PosterName;
@synthesize PosterUrl = _PosterUrl;

+ (NSString*) BodyKey
{
	return @"Body";
}

+ (NSString*) IsPrivateKey
{
	return @"IsPrivate";
}

+ (NSString*) PosterEmailKey
{
	return @"PosterEmail";
}

+ (NSString*) PosterNameKey
{
	return @"PosterName";
}

+ (NSString*) PosterUrlKey
{
	return @"PosterUrl";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFMessageUpdater*)object).PosterName = FLCopyOrRetainObject(_PosterName);
	((ZFMessageUpdater*)object).PosterUrl = FLCopyOrRetainObject(_PosterUrl);
	((ZFMessageUpdater*)object).IsPrivate = FLCopyOrRetainObject(_IsPrivate);
	((ZFMessageUpdater*)object).PosterEmail = FLCopyOrRetainObject(_PosterEmail);
	((ZFMessageUpdater*)object).Body = FLCopyOrRetainObject(_Body);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_PosterName);
	FLRelease(_PosterUrl);
	FLRelease(_PosterEmail);
	FLRelease(_Body);
	FLRelease(_IsPrivate);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_PosterName) [aCoder encodeObject:_PosterName forKey:@"_PosterName"];
	if(_PosterUrl) [aCoder encodeObject:_PosterUrl forKey:@"_PosterUrl"];
	if(_PosterEmail) [aCoder encodeObject:_PosterEmail forKey:@"_PosterEmail"];
	if(_Body) [aCoder encodeObject:_Body forKey:@"_Body"];
	if(_IsPrivate) [aCoder encodeObject:_IsPrivate forKey:@"_IsPrivate"];
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
		_PosterName = FLRetain([aDecoder decodeObjectForKey:@"_PosterName"]);
		_PosterUrl = FLRetain([aDecoder decodeObjectForKey:@"_PosterUrl"]);
		_PosterEmail = FLRetain([aDecoder decodeObjectForKey:@"_PosterEmail"]);
		_Body = FLRetain([aDecoder decodeObjectForKey:@"_Body"]);
		_IsPrivate = FLRetain([aDecoder decodeObjectForKey:@"_IsPrivate"]);
	}
	return self;
}

+ (ZFMessageUpdater*) messageUpdater
{
	return FLAutorelease([[ZFMessageUpdater alloc] init]);
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
		[s_describer addChildDescriberWithName:@"PosterName" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"PosterUrl" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"PosterEmail" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"Body" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"IsPrivate" withClass:[FLBoolNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PosterName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PosterUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PosterEmail" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Body" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsPrivate" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFMessageUpdater (ValueProperties) 

- (BOOL) IsPrivateValue
{
	return [self.IsPrivate boolValue];
}

- (void) setIsPrivateValue:(BOOL) value
{
	self.IsPrivate = [NSNumber numberWithBool:value];
}
@end

