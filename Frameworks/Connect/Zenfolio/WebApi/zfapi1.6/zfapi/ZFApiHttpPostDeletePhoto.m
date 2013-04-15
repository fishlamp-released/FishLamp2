//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostDeletePhoto.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApiHttpPostDeletePhoto.h"
#import "ZFDeletePhotoHttpPostIn.h"
#import "ZFDeletePhotoHttpPostOut.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFApiHttpPostDeletePhoto


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (ZFDeletePhotoHttpPostIn*) input
{
	if(!_input)
	{
		_input = [[ZFDeletePhotoHttpPostIn alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (ZFDeletePhotoHttpPostOut*) output
{
	if(!_output)
	{
		_output = [[ZFDeletePhotoHttpPostOut alloc] init];
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

+ (ZFApiHttpPostDeletePhoto*) apiHttpPostDeletePhoto
{
	return FLAutorelease([[ZFApiHttpPostDeletePhoto alloc] init]);
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
	return @"DeletePhoto";
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
		[s_describer setChildForIdentifier:@"input" withClass:[ZFDeletePhotoHttpPostIn class]];
		[s_describer setChildForIdentifier:@"output" withClass:[ZFDeletePhotoHttpPostOut class]];
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

@implementation ZFApiHttpPostDeletePhoto (ValueProperties) 
@end


@implementation ZFApiHttpPostDeletePhoto (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (ZFDeletePhotoHttpPostIn*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (ZFDeletePhotoHttpPostOut*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[ZFDeletePhotoHttpPostIn alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[ZFDeletePhotoHttpPostOut alloc] init];
	}
}
@end

