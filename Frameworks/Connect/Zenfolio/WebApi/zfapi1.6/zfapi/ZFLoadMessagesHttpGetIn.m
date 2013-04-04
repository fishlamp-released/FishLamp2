//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadMessagesHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadMessagesHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadMessagesHttpGetIn


@synthesize includeDeleted = _includeDeleted;
@synthesize mailboxId = _mailboxId;
@synthesize postedSince = _postedSince;

+ (NSString*) includeDeletedKey
{
	return @"includeDeleted";
}

+ (NSString*) mailboxIdKey
{
	return @"mailboxId";
}

+ (NSString*) postedSinceKey
{
	return @"postedSince";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadMessagesHttpGetIn*)object).mailboxId = FLCopyOrRetainObject(_mailboxId);
	((ZFLoadMessagesHttpGetIn*)object).includeDeleted = FLCopyOrRetainObject(_includeDeleted);
	((ZFLoadMessagesHttpGetIn*)object).postedSince = FLCopyOrRetainObject(_postedSince);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_mailboxId);
	FLRelease(_postedSince);
	FLRelease(_includeDeleted);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_mailboxId) [aCoder encodeObject:_mailboxId forKey:@"_mailboxId"];
	if(_postedSince) [aCoder encodeObject:_postedSince forKey:@"_postedSince"];
	if(_includeDeleted) [aCoder encodeObject:_includeDeleted forKey:@"_includeDeleted"];
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
		_mailboxId = FLRetain([aDecoder decodeObjectForKey:@"_mailboxId"]);
		_postedSince = FLRetain([aDecoder decodeObjectForKey:@"_postedSince"]);
		_includeDeleted = FLRetain([aDecoder decodeObjectForKey:@"_includeDeleted"]);
	}
	return self;
}

+ (ZFLoadMessagesHttpGetIn*) loadMessagesHttpGetIn
{
	return FLAutorelease([[ZFLoadMessagesHttpGetIn alloc] init]);
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
		[s_describer addChildDescriberWithName:@"mailboxId" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"postedSince" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"includeDeleted" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"postedSince" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includeDeleted" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadMessagesHttpGetIn (ValueProperties) 
@end

