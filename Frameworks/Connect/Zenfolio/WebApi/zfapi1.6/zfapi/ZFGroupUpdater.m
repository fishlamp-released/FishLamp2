//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGroupUpdater.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGroupUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGroupUpdater


@synthesize Caption = _Caption;
@synthesize CustomReference = _CustomReference;
@synthesize Title = _Title;

+ (NSString*) CaptionKey
{
	return @"Caption";
}

+ (NSString*) CustomReferenceKey
{
	return @"CustomReference";
}

+ (NSString*) TitleKey
{
	return @"Title";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGroupUpdater*)object).Title = FLCopyOrRetainObject(_Title);
	((ZFGroupUpdater*)object).Caption = FLCopyOrRetainObject(_Caption);
	((ZFGroupUpdater*)object).CustomReference = FLCopyOrRetainObject(_CustomReference);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Title);
	FLRelease(_Caption);
	FLRelease(_CustomReference);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Title) [aCoder encodeObject:_Title forKey:@"_Title"];
	if(_Caption) [aCoder encodeObject:_Caption forKey:@"_Caption"];
	if(_CustomReference) [aCoder encodeObject:_CustomReference forKey:@"_CustomReference"];
}

+ (ZFGroupUpdater*) groupUpdater
{
	return FLAutorelease([[ZFGroupUpdater alloc] init]);
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
		_Title = FLRetain([aDecoder decodeObjectForKey:@"_Title"]);
		_Caption = FLRetain([aDecoder decodeObjectForKey:@"_Caption"]);
		_CustomReference = FLRetain([aDecoder decodeObjectForKey:@"_CustomReference"]);
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
		[s_describer addProperty:@"Title" withClass:[NSString class]];
		[s_describer addProperty:@"Caption" withClass:[NSString class]];
		[s_describer addProperty:@"CustomReference" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Title" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Caption" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CustomReference" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGroupUpdater (ValueProperties) 
@end

