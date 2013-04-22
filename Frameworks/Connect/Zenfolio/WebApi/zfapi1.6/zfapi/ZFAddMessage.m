//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAddMessage.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAddMessage.h"
#import "ZFMessageUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAddMessage


@synthesize mailboxId = _mailboxId;
@synthesize updater = _updater;

+ (NSString*) mailboxIdKey
{
	return @"mailboxId";
}

+ (NSString*) updaterKey
{
	return @"updater";
}

+ (ZFAddMessage*) addMessage
{
	return FLAutorelease([[ZFAddMessage alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAddMessage*)object).mailboxId = FLCopyOrRetainObject(_mailboxId);
	((ZFAddMessage*)object).updater = FLCopyOrRetainObject(_updater);
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
	FLRelease(_updater);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_mailboxId) [aCoder encodeObject:_mailboxId forKey:@"_mailboxId"];
	if(_updater) [aCoder encodeObject:_updater forKey:@"_updater"];
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
		_updater = FLRetain([aDecoder decodeObjectForKey:@"_updater"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"mailboxId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"updater" withClass:[ZFMessageUpdater class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updater" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAddMessage (ValueProperties) 
@end

