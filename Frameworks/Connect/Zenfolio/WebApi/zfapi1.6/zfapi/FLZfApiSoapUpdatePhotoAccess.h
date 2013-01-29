//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapUpdatePhotoAccess.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Updates photo access descriptor. <A href="/zf/help/api/ref/methods/updatephotoaccess">More...</A>
*/



@class FLZfUpdatePhotoAccess;
@class FLZfUpdatePhotoAccessResponse;

// --------------------------------------------------------------------
// FLZfApiSoapUpdatePhotoAccess
// --------------------------------------------------------------------
@interface FLZfApiSoapUpdatePhotoAccess : NSObject{ 
@private
	FLZfUpdatePhotoAccess* _input;
	FLZfUpdatePhotoAccessResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfUpdatePhotoAccess* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfUpdatePhotoAccessResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapUpdatePhotoAccess*) apiSoapUpdatePhotoAccess; 

@end

@interface FLZfApiSoapUpdatePhotoAccess (ValueProperties) 
@end


@interface FLZfApiSoapUpdatePhotoAccess (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfUpdatePhotoAccess* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfUpdatePhotoAccessResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

