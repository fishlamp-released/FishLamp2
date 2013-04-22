//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFDeleteMessageHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFDeleteMessageHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFDeleteMessageHttpPostIn


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
	((ZFDeleteMessageHttpPostIn*)object).mailboxId = FLCopyOrRetainObject(_mailboxId);
	((ZFDeleteMessageHttpPostIn*)object).messageIndex = FLCopyOrRetainObject(_messageIndex);
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

+ (ZFDeleteMessageHttpPostIn*) deleteMessageHttpPostIn
{
	return FLAutorelease([[ZFDeleteMessageHttpPostIn alloc] init]);
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

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"mailboxId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"messageIndex" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"messageIndex" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFDeleteMessageHttpPostIn (ValueProperties) 
@end

