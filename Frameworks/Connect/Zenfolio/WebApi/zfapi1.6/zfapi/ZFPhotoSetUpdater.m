//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhotoSetUpdater.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFPhotoSetUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFPhotoSetUpdater


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
	((ZFPhotoSetUpdater*)object).Keywords = FLCopyOrRetainObject(_Keywords);
	((ZFPhotoSetUpdater*)object).Categories = FLCopyOrRetainObject(_Categories);
	((ZFPhotoSetUpdater*)object).Title = FLCopyOrRetainObject(_Title);
	((ZFPhotoSetUpdater*)object).Caption = FLCopyOrRetainObject(_Caption);
	((ZFPhotoSetUpdater*)object).CustomReference = FLCopyOrRetainObject(_CustomReference);
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

+ (ZFPhotoSetUpdater*) photoSetUpdater
{
	return FLAutorelease([[ZFPhotoSetUpdater alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"Title" withClass:[NSString class]];
		[describer setChildForIdentifier:@"Caption" withClass:[NSString class]];
		[describer setChildForIdentifier:@"Keywords" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"Keyword" class:[NSString class] ], nil]];
		[describer setChildForIdentifier:@"Categories" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"Category" class:[FLIntegerNumber class]], nil]];
		[describer setChildForIdentifier:@"CustomReference" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CustomReference" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFPhotoSetUpdater (ValueProperties) 
@end

