//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostSetGroupTitlePhoto.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFApiHttpPostSetGroupTitlePhoto.h"
#import "ZFSetGroupTitlePhotoHttpPostIn.h"
#import "ZFSetGroupTitlePhotoHttpPostOut.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFApiHttpPostSetGroupTitlePhoto


@synthesize input = _input;

// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.
- (ZFSetGroupTitlePhotoHttpPostIn*) input
{
	if(!_input)
	{
		_input = [[ZFSetGroupTitlePhotoHttpPostIn alloc] init];
	}
	return _input;
}
@synthesize output = _output;

// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.
- (ZFSetGroupTitlePhotoHttpPostOut*) output
{
	if(!_output)
	{
		_output = [[ZFSetGroupTitlePhotoHttpPostOut alloc] init];
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

+ (ZFApiHttpPostSetGroupTitlePhoto*) apiHttpPostSetGroupTitlePhoto
{
	return FLAutorelease([[ZFApiHttpPostSetGroupTitlePhoto alloc] init]);
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
	return @"SetGroupTitlePhoto";
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"input" withClass:[ZFSetGroupTitlePhotoHttpPostIn class]];
		[describer setChildForIdentifier:@"output" withClass:[ZFSetGroupTitlePhotoHttpPostOut class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"input" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"output" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFApiHttpPostSetGroupTitlePhoto (ValueProperties) 
@end


@implementation ZFApiHttpPostSetGroupTitlePhoto (ObjectMembers) 

// This returns _input. It does NOT create it if it's NIL.
- (ZFSetGroupTitlePhotoHttpPostIn*) inputObject
{
	return _input;
}

// This returns _output. It does NOT create it if it's NIL.
- (ZFSetGroupTitlePhotoHttpPostOut*) outputObject
{
	return _output;
}

- (void) createInputIfNil
{
	if(!_input)
	{
		_input = [[ZFSetGroupTitlePhotoHttpPostIn alloc] init];
	}
}

- (void) createOutputIfNil
{
	if(!_output)
	{
		_output = [[ZFSetGroupTitlePhotoHttpPostOut alloc] init];
	}
}
@end

