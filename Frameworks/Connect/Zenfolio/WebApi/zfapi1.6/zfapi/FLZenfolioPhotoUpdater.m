//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhotoUpdater.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioPhotoUpdater.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioPhotoUpdater


@synthesize Caption = _Caption;
@synthesize Categories = _Categories;
@synthesize Copyright = _Copyright;
@synthesize FileName = _FileName;
@synthesize Keywords = _Keywords;
@synthesize Title = _Title;

+ (NSString*) CaptionKey
{
	return @"Caption";
}

+ (NSString*) CategoriesKey
{
	return @"Categories";
}

+ (NSString*) CopyrightKey
{
	return @"Copyright";
}

+ (NSString*) FileNameKey
{
	return @"FileName";
}

+ (NSString*) KeywordsKey
{
	return @"Keywords";
}

+ (NSString*) TitleKey
{
	return @"Title";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioPhotoUpdater*)object).Keywords = FLCopyOrRetainObject(_Keywords);
	((FLZenfolioPhotoUpdater*)object).Categories = FLCopyOrRetainObject(_Categories);
	((FLZenfolioPhotoUpdater*)object).FileName = FLCopyOrRetainObject(_FileName);
	((FLZenfolioPhotoUpdater*)object).Title = FLCopyOrRetainObject(_Title);
	((FLZenfolioPhotoUpdater*)object).Caption = FLCopyOrRetainObject(_Caption);
	((FLZenfolioPhotoUpdater*)object).Copyright = FLCopyOrRetainObject(_Copyright);
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
	FLRelease(_Keywords);
	FLRelease(_Categories);
	FLRelease(_Copyright);
	FLRelease(_FileName);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Title) [aCoder encodeObject:_Title forKey:@"_Title"];
	if(_Caption) [aCoder encodeObject:_Caption forKey:@"_Caption"];
	if(_Keywords) [aCoder encodeObject:_Keywords forKey:@"_Keywords"];
	if(_Categories) [aCoder encodeObject:_Categories forKey:@"_Categories"];
	if(_Copyright) [aCoder encodeObject:_Copyright forKey:@"_Copyright"];
	if(_FileName) [aCoder encodeObject:_FileName forKey:@"_FileName"];
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
		_Keywords = [[aDecoder decodeObjectForKey:@"_Keywords"] mutableCopy];
		_Categories = [[aDecoder decodeObjectForKey:@"_Categories"] mutableCopy];
		_Copyright = FLRetain([aDecoder decodeObjectForKey:@"_Copyright"]);
		_FileName = FLRetain([aDecoder decodeObjectForKey:@"_FileName"]);
	}
	return self;
}

+ (FLZenfolioPhotoUpdater*) photoUpdater
{
	return FLAutorelease([[FLZenfolioPhotoUpdater alloc] init]);
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
		[s_describer addProperty:@"Title" withClass:[NSString class]];
		[s_describer addProperty:@"Caption" withClass:[NSString class]];
		[s_describer addArrayProperty:@"Keywords" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Keyword" propertyClass:[NSString class] ], nil]];
		[s_describer addArrayProperty:@"Categories" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Category" propertyClass:[FLIntegerNumber class]], nil]];
		[s_describer addProperty:@"Copyright" withClass:[NSString class]];
		[s_describer addProperty:@"FileName" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Title" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Caption" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Keywords" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Categories" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Copyright" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"FileName" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioPhotoUpdater (ValueProperties) 
@end

