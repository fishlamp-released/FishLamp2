//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUpdatePhoto.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApiSoapUpdatePhoto.h"
#import "ZFUpdatePhoto.h"
#import "ZFUpdatePhotoResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFApiSoapUpdatePhoto


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (ZFUpdatePhoto*) input
{
	if(!_input)
	{
		_input = [[ZFUpdatePhoto alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (ZFUpdatePhotoResponse*) output
{
	if(!_output)
	{
		_output = [[ZFUpdatePhotoResponse alloc] init];
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

+ (ZFApiSoapUpdatePhoto*) apiSoapUpdatePhoto
{
	return FLAutorelease([[ZFApiSoapUpdatePhoto alloc] init]);
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
	return @"UpdatePhoto";
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
		[s_describer setChildForIdentifier:@"input" withClass:[ZFUpdatePhoto class]];
		[s_describer setChildForIdentifier:@"output" withClass:[ZFUpdatePhotoResponse class]];
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

@implementation ZFApiSoapUpdatePhoto (ValueProperties) 
@end


@implementation ZFApiSoapUpdatePhoto (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (ZFUpdatePhoto*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (ZFUpdatePhotoResponse*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[ZFUpdatePhoto alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[ZFUpdatePhotoResponse alloc] init];
	}
}
@end

