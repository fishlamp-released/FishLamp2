//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfApiSoapUndeleteMessage.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Marks the specified message as not deleted. The mailbox must be owned by the currently authenticated user. <A href="/zf/help/api/ref/methods/undeletemessage">More...</A>
*/



@class FLZfUndeleteMessage;
@class FLZfUndeleteMessageResponse;

// --------------------------------------------------------------------
// FLZfApiSoapUndeleteMessage
// --------------------------------------------------------------------
@interface FLZfApiSoapUndeleteMessage : NSObject{ 
@private
	FLZfUndeleteMessage* _input;
	FLZfUndeleteMessageResponse* _output;
} 


@property (readwrite, retain, nonatomic) FLZfUndeleteMessage* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) FLZfUndeleteMessageResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLZfApiSoapUndeleteMessage*) apiSoapUndeleteMessage; 

@end

@interface FLZfApiSoapUndeleteMessage (ValueProperties) 
@end


@interface FLZfApiSoapUndeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) FLZfUndeleteMessage* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) FLZfUndeleteMessageResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

