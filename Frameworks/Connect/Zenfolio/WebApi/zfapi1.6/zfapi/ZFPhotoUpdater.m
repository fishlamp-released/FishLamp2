//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhotoUpdater.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFPhotoUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFPhotoUpdater


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
	((ZFPhotoUpdater*)object).Keywords = FLCopyOrRetainObject(_Keywords);
	((ZFPhotoUpdater*)object).Categories = FLCopyOrRetainObject(_Categories);
	((ZFPhotoUpdater*)object).FileName = FLCopyOrRetainObject(_FileName);
	((ZFPhotoUpdater*)object).Title = FLCopyOrRetainObject(_Title);
	((ZFPhotoUpdater*)object).Caption = FLCopyOrRetainObject(_Caption);
	((ZFPhotoUpdater*)object).Copyright = FLCopyOrRetainObject(_Copyright);
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

+ (ZFPhotoUpdater*) photoUpdater
{
	return FLAutorelease([[ZFPhotoUpdater alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"Title" withClass:[NSString class]];
		[describer setChildForIdentifier:@"Caption" withClass:[NSString class]];
		[describer setChildForIdentifier:@"Keywords" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"Keyword" class:[NSString class] ], nil]];
		[describer setChildForIdentifier:@"Categories" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyDescriber propertyDescriber:@"Category" class:[FLIntegerNumber class]], nil]];
		[describer setChildForIdentifier:@"Copyright" withClass:[NSString class]];
		[describer setChildForIdentifier:@"FileName" withClass:[NSString class]];
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

@implementation ZFPhotoUpdater (ValueProperties) 
@end

