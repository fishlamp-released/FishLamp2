//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhotoSetUpdater.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioPhotoSetUpdater.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioPhotoSetUpdater


@synthesize Caption = _Caption;
@synthesize Categories = _Categories;
@synthesize CustomReference = _CustomReference;
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

+ (NSString*) CustomReferenceKey
{
	return @"CustomReference";
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
	((FLZenfolioPhotoSetUpdater*)object).Keywords = FLCopyOrRetainObject(_Keywords);
	((FLZenfolioPhotoSetUpdater*)object).Categories = FLCopyOrRetainObject(_Categories);
	((FLZenfolioPhotoSetUpdater*)object).Title = FLCopyOrRetainObject(_Title);
	((FLZenfolioPhotoSetUpdater*)object).Caption = FLCopyOrRetainObject(_Caption);
	((FLZenfolioPhotoSetUpdater*)object).CustomReference = FLCopyOrRetainObject(_CustomReference);
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
	FLRelease(_CustomReference);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Title) [aCoder encodeObject:_Title forKey:@"_Title"];
	if(_Caption) [aCoder encodeObject:_Caption forKey:@"_Caption"];
	if(_Keywords) [aCoder encodeObject:_Keywords forKey:@"_Keywords"];
	if(_Categories) [aCoder encodeObject:_Categories forKey:@"_Categories"];
	if(_CustomReference) [aCoder encodeObject:_CustomReference forKey:@"_CustomReference"];
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
		_CustomReference = FLRetain([aDecoder decodeObjectForKey:@"_CustomReference"]);
	}
	return self;
}

+ (FLZenfolioPhotoSetUpdater*) photoSetUpdater
{
	return FLAutorelease([[FLZenfolioPhotoSetUpdater alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Title" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Title"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Caption" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Caption"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Keywords" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"Keyword" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"Keywords"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Categories" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"Category" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"Categories"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"CustomReference" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"CustomReference"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CustomReference" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioPhotoSetUpdater (ValueProperties) 
@end

