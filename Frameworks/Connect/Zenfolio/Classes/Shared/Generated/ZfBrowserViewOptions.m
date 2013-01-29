//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFBrowserViewOptions.m
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFBrowserViewOptions.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFBrowserViewOptions


@synthesize elementId = _elementId;
@synthesize showIndexNumber = _showIndexNumber;
@synthesize showTitle = _showTitle;

+ (NSString*) elementIdKey
{
	return @"elementId";
}

+ (NSString*) showIndexNumberKey
{
	return @"showIndexNumber";
}

+ (NSString*) showTitleKey
{
	return @"showTitle";
}

+ (ZFBrowserViewOptions*) browserViewOptions
{
	return FLAutorelease([[ZFBrowserViewOptions alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFBrowserViewOptions*)object).showIndexNumber = FLCopyOrRetainObject(_showIndexNumber);
	((ZFBrowserViewOptions*)object).showTitle = FLCopyOrRetainObject(_showTitle);
	((ZFBrowserViewOptions*)object).elementId = FLCopyOrRetainObject(_elementId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_elementId);
	FLRelease(_showIndexNumber);
	FLRelease(_showTitle);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_elementId) [aCoder encodeObject:_elementId forKey:@"_elementId"];
	if(_showIndexNumber) [aCoder encodeObject:_showIndexNumber forKey:@"_showIndexNumber"];
	if(_showTitle) [aCoder encodeObject:_showTitle forKey:@"_showTitle"];
	[super encodeWithCoder:aCoder];
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
	if((self = [super initWithCoder:aDecoder]))
	{
		_elementId = FLRetain([aDecoder decodeObjectForKey:@"_elementId"]);
		_showIndexNumber = FLRetain([aDecoder decodeObjectForKey:@"_showIndexNumber"]);
		_showTitle = FLRetain([aDecoder decodeObjectForKey:@"_showTitle"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"elementId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"elementId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"showIndexNumber" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"showIndexNumber"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"showTitle" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"showTitle"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"elementId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addIndex:[FLDatabaseIndex databaseIndex:@"elementId" indexProperties:FLDatabaseColumnIndexPropertyNone]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"showIndexNumber" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"showTitle" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFBrowserViewOptions (ValueProperties) 

- (int) elementIdValue
{
	return [self.elementId intValue];
}

- (void) setElementIdValue:(int) value
{
	self.elementId = [NSNumber numberWithInt:value];
}

- (BOOL) showIndexNumberValue
{
	return [self.showIndexNumber boolValue];
}

- (void) setShowIndexNumberValue:(BOOL) value
{
	self.showIndexNumber = [NSNumber numberWithBool:value];
}

- (BOOL) showTitleValue
{
	return [self.showTitle boolValue];
}

- (void) setShowTitleValue:(BOOL) value
{
	self.showTitle = [NSNumber numberWithBool:value];
}
@end

