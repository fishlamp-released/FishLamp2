//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMessage.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFMessage.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFMessage


@synthesize Body = _Body;
@synthesize Index = _Index;
@synthesize IsPrivate = _IsPrivate;
@synthesize MailboxId = _MailboxId;
@synthesize PostedOn = _PostedOn;
@synthesize PosterEmail = _PosterEmail;
@synthesize PosterLoginNane = _PosterLoginNane;
@synthesize PosterName = _PosterName;
@synthesize PosterUrl = _PosterUrl;

+ (NSString*) BodyKey
{
	return @"Body";
}

+ (NSString*) IndexKey
{
	return @"Index";
}

+ (NSString*) IsPrivateKey
{
	return @"IsPrivate";
}

+ (NSString*) MailboxIdKey
{
	return @"MailboxId";
}

+ (NSString*) PostedOnKey
{
	return @"PostedOn";
}

+ (NSString*) PosterEmailKey
{
	return @"PosterEmail";
}

+ (NSString*) PosterLoginNaneKey
{
	return @"PosterLoginNane";
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
	((ZFMessage*)object).IsPrivate = FLCopyOrRetainObject(_IsPrivate);
	((ZFMessage*)object).Index = FLCopyOrRetainObject(_Index);
	((ZFMessage*)object).PosterName = FLCopyOrRetainObject(_PosterName);
	((ZFMessage*)object).PosterUrl = FLCopyOrRetainObject(_PosterUrl);
	((ZFMessage*)object).PostedOn = FLCopyOrRetainObject(_PostedOn);
	((ZFMessage*)object).PosterLoginNane = FLCopyOrRetainObject(_PosterLoginNane);
	((ZFMessage*)object).Body = FLCopyOrRetainObject(_Body);
	((ZFMessage*)object).PosterEmail = FLCopyOrRetainObject(_PosterEmail);
	((ZFMessage*)object).MailboxId = FLCopyOrRetainObject(_MailboxId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_MailboxId);
	FLRelease(_Index);
	FLRelease(_PostedOn);
	FLRelease(_PosterName);
	FLRelease(_PosterLoginNane);
	FLRelease(_PosterUrl);
	FLRelease(_PosterEmail);
	FLRelease(_Body);
	FLRelease(_IsPrivate);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_MailboxId) [aCoder encodeObject:_MailboxId forKey:@"_MailboxId"];
	if(_Index) [aCoder encodeObject:_Index forKey:@"_Index"];
	if(_PostedOn) [aCoder encodeObject:_PostedOn forKey:@"_PostedOn"];
	if(_PosterName) [aCoder encodeObject:_PosterName forKey:@"_PosterName"];
	if(_PosterLoginNane) [aCoder encodeObject:_PosterLoginNane forKey:@"_PosterLoginNane"];
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
		_MailboxId = FLRetain([aDecoder decodeObjectForKey:@"_MailboxId"]);
		_Index = FLRetain([aDecoder decodeObjectForKey:@"_Index"]);
		_PostedOn = FLRetain([aDecoder decodeObjectForKey:@"_PostedOn"]);
		_PosterName = FLRetain([aDecoder decodeObjectForKey:@"_PosterName"]);
		_PosterLoginNane = FLRetain([aDecoder decodeObjectForKey:@"_PosterLoginNane"]);
		_PosterUrl = FLRetain([aDecoder decodeObjectForKey:@"_PosterUrl"]);
		_PosterEmail = FLRetain([aDecoder decodeObjectForKey:@"_PosterEmail"]);
		_Body = FLRetain([aDecoder decodeObjectForKey:@"_Body"]);
		_IsPrivate = FLRetain([aDecoder decodeObjectForKey:@"_IsPrivate"]);
	}
	return self;
}

+ (ZFMessage*) message
{
	return FLAutorelease([[ZFMessage alloc] init]);
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
		[s_describer addChildDescriberWithName:@"MailboxId" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"Index" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"PostedOn" withClass:[NSDate class]];
		[s_describer addChildDescriberWithName:@"PosterName" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"PosterLoginNane" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"MailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Index" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PostedOn" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PosterName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PosterLoginNane" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PosterUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PosterEmail" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Body" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"IsPrivate" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFMessage (ValueProperties) 

- (int) IndexValue
{
	return [self.Index intValue];
}

- (void) setIndexValue:(int) value
{
	self.Index = [NSNumber numberWithInt:value];
}

- (BOOL) IsPrivateValue
{
	return [self.IsPrivate boolValue];
}

- (void) setIsPrivateValue:(BOOL) value
{
	self.IsPrivate = [NSNumber numberWithBool:value];
}
@end

