//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadMessages.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadMessages.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadMessages


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
	((ZFLoadMessages*)object).mailboxId = FLCopyOrRetainObject(_mailboxId);
	((ZFLoadMessages*)object).includeDeleted = FLCopyOrRetainObject(_includeDeleted);
	((ZFLoadMessages*)object).postedSince = FLCopyOrRetainObject(_postedSince);
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

+ (ZFLoadMessages*) loadMessages
{
	return FLAutorelease([[ZFLoadMessages alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"mailboxId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"postedSince" withClass:[NSDate class]];
		[describer setChildForIdentifier:@"includeDeleted" withClass:[FLBoolNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mailboxId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"postedSince" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includeDeleted" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadMessages (ValueProperties) 

- (BOOL) includeDeletedValue
{
	return [self.includeDeleted boolValue];
}

- (void) setIncludeDeletedValue:(BOOL) value
{
	self.includeDeleted = [NSNumber numberWithBool:value];
}
@end

