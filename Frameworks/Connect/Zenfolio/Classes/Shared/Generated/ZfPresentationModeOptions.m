//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPresentationModeOptions.m
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFPresentationModeOptions.h"
#import "FLSlideshowOptions.h"
#import "ZFBrowserViewOptions.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFPresentationModeOptions


@synthesize browserViewOptions = _browserViewOptions;
@synthesize name = _name;
@synthesize pin = _pin;
@synthesize slideshowOptions = _slideshowOptions;
@synthesize usePin = _usePin;

+ (NSString*) browserViewOptionsKey
{
	return @"browserViewOptions";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) pinKey
{
	return @"pin";
}

+ (NSString*) slideshowOptionsKey
{
	return @"slideshowOptions";
}

+ (NSString*) usePinKey
{
	return @"usePin";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFPresentationModeOptions*)object).browserViewOptions = FLCopyOrRetainObject(_browserViewOptions);
	((ZFPresentationModeOptions*)object).usePin = FLCopyOrRetainObject(_usePin);
	((ZFPresentationModeOptions*)object).slideshowOptions = FLCopyOrRetainObject(_slideshowOptions);
	((ZFPresentationModeOptions*)object).pin = FLCopyOrRetainObject(_pin);
	((ZFPresentationModeOptions*)object).name = FLCopyOrRetainObject(_name);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_pin);
	FLRelease(_name);
	FLRelease(_slideshowOptions);
	FLRelease(_browserViewOptions);
	FLRelease(_usePin);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_pin) [aCoder encodeObject:_pin forKey:@"_pin"];
	if(_name) [aCoder encodeObject:_name forKey:@"_name"];
	if(_slideshowOptions) [aCoder encodeObject:_slideshowOptions forKey:@"_slideshowOptions"];
	if(_browserViewOptions) [aCoder encodeObject:_browserViewOptions forKey:@"_browserViewOptions"];
	if(_usePin) [aCoder encodeObject:_usePin forKey:@"_usePin"];
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
		_pin = FLRetain([aDecoder decodeObjectForKey:@"_pin"]);
		_name = FLRetain([aDecoder decodeObjectForKey:@"_name"]);
		_slideshowOptions = FLRetain([aDecoder decodeObjectForKey:@"_slideshowOptions"]);
		_browserViewOptions = FLRetain([aDecoder decodeObjectForKey:@"_browserViewOptions"]);
		_usePin = FLRetain([aDecoder decodeObjectForKey:@"_usePin"]);
	}
	return self;
}

+ (ZFPresentationModeOptions*) presentationModeOptions
{
	return FLAutorelease([[ZFPresentationModeOptions alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"pin" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"pin"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"name"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"slideshowOptions" propertyClass:[FLSlideshowOptions class] propertyType:FLDataTypeObject] forPropertyName:@"slideshowOptions"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"browserViewOptions" propertyClass:[ZFBrowserViewOptions class] propertyType:FLDataTypeObject] forPropertyName:@"browserViewOptions"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"usePin" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"usePin"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"pin" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"slideshowOptions" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"browserViewOptions" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"usePin" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFPresentationModeOptions (ValueProperties) 

- (BOOL) usePinValue
{
	return [self.usePin boolValue];
}

- (void) setUsePinValue:(BOOL) value
{
	self.usePin = [NSNumber numberWithBool:value];
}
@end

