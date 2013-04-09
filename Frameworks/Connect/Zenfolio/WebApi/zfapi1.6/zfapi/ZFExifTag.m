//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFExifTag.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFExifTag.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFExifTag


@synthesize DisplayValue = _DisplayValue;
@synthesize Id = _Id;
@synthesize Value = _Value;

+ (NSString*) DisplayValueKey
{
	return @"DisplayValue";
}

+ (NSString*) IdKey
{
	return @"Id";
}

+ (NSString*) ValueKey
{
	return @"Value";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFExifTag*)object).Value = FLCopyOrRetainObject(_Value);
	((ZFExifTag*)object).Id = FLCopyOrRetainObject(_Id);
	((ZFExifTag*)object).DisplayValue = FLCopyOrRetainObject(_DisplayValue);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Id);
	FLRelease(_Value);
	FLRelease(_DisplayValue);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Id) [aCoder encodeObject:_Id forKey:@"_Id"];
	if(_Value) [aCoder encodeObject:_Value forKey:@"_Value"];
	if(_DisplayValue) [aCoder encodeObject:_DisplayValue forKey:@"_DisplayValue"];
}

+ (ZFExifTag*) exifTag
{
	return FLAutorelease([[ZFExifTag alloc] init]);
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
		_Id = FLRetain([aDecoder decodeObjectForKey:@"_Id"]);
		_Value = FLRetain([aDecoder decodeObjectForKey:@"_Value"]);
		_DisplayValue = FLRetain([aDecoder decodeObjectForKey:@"_DisplayValue"]);
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
		[s_describer addChildDescriberWithName:@"Id" withClass:[FLIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Value" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"DisplayValue" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Id" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Value" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"DisplayValue" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFExifTag (ValueProperties) 

- (int) IdValue
{
	return [self.Id intValue];
}

- (void) setIdValue:(int) value
{
	self.Id = [NSNumber numberWithInt:value];
}
@end
