//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFFile.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFFile.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFFile


@synthesize Height = _Height;
@synthesize Id = _Id;
@synthesize MimeType = _MimeType;
@synthesize Sequence = _Sequence;
@synthesize UrlCore = _UrlCore;
@synthesize UrlHost = _UrlHost;
@synthesize Width = _Width;

+ (NSString*) HeightKey
{
	return @"Height";
}

+ (NSString*) IdKey
{
	return @"Id";
}

+ (NSString*) MimeTypeKey
{
	return @"MimeType";
}

+ (NSString*) SequenceKey
{
	return @"Sequence";
}

+ (NSString*) UrlCoreKey
{
	return @"UrlCore";
}

+ (NSString*) UrlHostKey
{
	return @"UrlHost";
}

+ (NSString*) WidthKey
{
	return @"Width";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFFile*)object).Height = FLCopyOrRetainObject(_Height);
	((ZFFile*)object).UrlCore = FLCopyOrRetainObject(_UrlCore);
	((ZFFile*)object).Id = FLCopyOrRetainObject(_Id);
	((ZFFile*)object).MimeType = FLCopyOrRetainObject(_MimeType);
	((ZFFile*)object).UrlHost = FLCopyOrRetainObject(_UrlHost);
	((ZFFile*)object).Sequence = FLCopyOrRetainObject(_Sequence);
	((ZFFile*)object).Width = FLCopyOrRetainObject(_Width);
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
	FLRelease(_Width);
	FLRelease(_Height);
	FLRelease(_Sequence);
	FLRelease(_MimeType);
	FLRelease(_UrlCore);
	FLRelease(_UrlHost);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Id) [aCoder encodeObject:_Id forKey:@"_Id"];
	if(_Width) [aCoder encodeObject:_Width forKey:@"_Width"];
	if(_Height) [aCoder encodeObject:_Height forKey:@"_Height"];
	if(_Sequence) [aCoder encodeObject:_Sequence forKey:@"_Sequence"];
	if(_MimeType) [aCoder encodeObject:_MimeType forKey:@"_MimeType"];
	if(_UrlCore) [aCoder encodeObject:_UrlCore forKey:@"_UrlCore"];
	if(_UrlHost) [aCoder encodeObject:_UrlHost forKey:@"_UrlHost"];
}

+ (ZFFile*) file
{
	return FLAutorelease([[ZFFile alloc] init]);
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
		_Width = FLRetain([aDecoder decodeObjectForKey:@"_Width"]);
		_Height = FLRetain([aDecoder decodeObjectForKey:@"_Height"]);
		_Sequence = FLRetain([aDecoder decodeObjectForKey:@"_Sequence"]);
		_MimeType = FLRetain([aDecoder decodeObjectForKey:@"_MimeType"]);
		_UrlCore = FLRetain([aDecoder decodeObjectForKey:@"_UrlCore"]);
		_UrlHost = FLRetain([aDecoder decodeObjectForKey:@"_UrlHost"]);
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
		[s_describer addChildDescriberWithName:@"Width" withClass:[FLUnsignedIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Height" withClass:[FLUnsignedIntegerNumber class] ];
		[s_describer addChildDescriberWithName:@"Sequence" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"MimeType" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"UrlCore" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"UrlHost" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Width" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Height" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Sequence" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"MimeType" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UrlCore" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UrlHost" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFFile (ValueProperties) 

- (int) IdValue
{
	return [self.Id intValue];
}

- (void) setIdValue:(int) value
{
	self.Id = [NSNumber numberWithInt:value];
}

- (unsigned int) WidthValue
{
	return [self.Width unsignedIntValue];
}

- (void) setWidthValue:(unsigned int) value
{
	self.Width = [NSNumber numberWithUnsignedInt:value];
}

- (unsigned int) HeightValue
{
	return [self.Height unsignedIntValue];
}

- (void) setHeightValue:(unsigned int) value
{
	self.Height = [NSNumber numberWithUnsignedInt:value];
}
@end
