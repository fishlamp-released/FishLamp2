//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfDeleteMessageHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfDeleteMessageHttpPostIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfDeleteMessageHttpPostIn


@synthesize mailboxId = _mailboxId;
@synthesize messageIndex = _messageIndex;

+ (NSString*) mailboxIdKey
{
	return @"mailboxId";
}

+ (NSString*) messageIndexKey
{
	return @"messageIndex";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfDeleteMessageHttpPostIn*)object).mailboxId = FLCopyOrRetainObject(_mailboxId);
	((FLZfDeleteMessageHttpPostIn*)object).messageIndex = FLCopyOrRetainObject(_messageIndex);
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
	FLRelease(_messageIndex);
	FLSuperDealloc();
}

+ (FLZfDeleteMessageHttpPostIn*) deleteMessageHttpPostIn
{
	return FLAutorelease([[FLZfDeleteMessageHttpPostIn alloc] init]);
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_mailboxId) [aCoder encodeObject:_mailboxId forKey:@"_mailboxId"];
	if(_messageIndex) [aCoder encodeObject:_messageIndex forKey:@"_messageIndex"];
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
		_messageIndex = FLRetain([aDecoder decodeObjectForKey:@"_messageIndex"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"mailboxId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"mailboxId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"messageIndex" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"messageIndex"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"messageIndex" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfDeleteMessageHttpPostIn (ValueProperties) 
@end

