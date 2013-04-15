//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpGetSetPhotoSetTitlePhoto.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApiHttpGetSetPhotoSetTitlePhoto.h"
#import "ZFSetPhotoSetTitlePhotoHttpGetIn.h"
#import "ZFSetPhotoSetTitlePhotoHttpGetOut.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFApiHttpGetSetPhotoSetTitlePhoto


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (ZFSetPhotoSetTitlePhotoHttpGetIn*) input
{
	if(!_input)
	{
		_input = [[ZFSetPhotoSetTitlePhotoHttpGetIn alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (ZFSetPhotoSetTitlePhotoHttpGetOut*) output
{
	if(!_output)
	{
		_output = [[ZFSetPhotoSetTitlePhotoHttpGetOut alloc] init];
	}
	return _output;
}

+ (NSString*) inputKey
{
	return @"input";
}

+ (NSString*) outputKey
{
	return @"output";
}

+ (ZFApiHttpGetSetPhotoSetTitlePhoto*) apiHttpGetSetPhotoSetTitlePhoto
{
	return FLAutorelease([[ZFApiHttpGetSetPhotoSetTitlePhoto alloc] init]);
}

- (void) dealloc
{
	FLRelease(_input);
	FLRelease(_output);
	FLSuperDealloc();
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (NSString*) operationName
{
	return @"SetPhotoSetTitlePhoto";
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
		[s_describer setChildForIdentifier:@"input" withClass:[ZFSetPhotoSetTitlePhotoHttpGetIn class]];
		[s_describer setChildForIdentifier:@"output" withClass:[ZFSetPhotoSetTitlePhotoHttpGetOut class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"input" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"output" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFApiHttpGetSetPhotoSetTitlePhoto (ValueProperties) 
@end


@implementation ZFApiHttpGetSetPhotoSetTitlePhoto (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (ZFSetPhotoSetTitlePhotoHttpGetIn*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (ZFSetPhotoSetTitlePhotoHttpGetOut*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[ZFSetPhotoSetTitlePhotoHttpGetIn alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[ZFSetPhotoSetTitlePhotoHttpGetOut alloc] init];
	}
}
@end

