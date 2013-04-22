//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadMessagesHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadMessagesHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadMessagesHttpPostIn


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
	((ZFLoadMessagesHttpPostIn*)object).mailboxId = FLCopyOrRetainObject(_mailboxId);
	((ZFLoadMessagesHttpPostIn*)object).includeDeleted = FLCopyOrRetainObject(_includeDeleted);
	((ZFLoadMessagesHttpPostIn*)object).postedSince = FLCopyOrRetainObject(_postedSince);
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

+ (ZFLoadMessagesHttpPostIn*) loadMessagesHttpPostIn
{
	return FLAutorelease([[ZFLoadMessagesHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"mailboxId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"postedSince" withClass:[NSString class]];
		[describer setChildForIdentifier:@"includeDeleted" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"postedSince" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includeDeleted" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadMessagesHttpPostIn (ValueProperties) 
@end

