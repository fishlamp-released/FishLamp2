//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiSoapUndeleteMessage.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/

/*
Marks the specified message as not deleted. The mailbox must be owned by the currently authenticated user. <A href="/zf/help/api/ref/methods/undeletemessage">More...</A>
*/



@class ZFUndeleteMessage;
@class ZFUndeleteMessageResponse;

// --------------------------------------------------------------------
// ZFApiSoapUndeleteMessage
// --------------------------------------------------------------------
@interface ZFApiSoapUndeleteMessage : NSObject{ 
@private
	ZFUndeleteMessage* _input;
	ZFUndeleteMessageResponse* _output;
} 


@property (readwrite, retain, nonatomic) ZFUndeleteMessage* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) ZFUndeleteMessageResponse* output;
// Getter will create _output if nil. Alternately, use the outputObject property, which will not lazy create it.

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiSoapUndeleteMessage*) apiSoapUndeleteMessage; 

@end

@interface ZFApiSoapUndeleteMessage (ValueProperties) 
@end


@interface ZFApiSoapUndeleteMessage (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFUndeleteMessage* inputObject;
// This returns _input. It does NOT create it if it's NIL.

@property (readonly, retain, nonatomic) ZFUndeleteMessageResponse* outputObject;
// This returns _output. It does NOT create it if it's NIL.

- (void) createInputIfNil; 

- (void) createOutputIfNil; 
@end

