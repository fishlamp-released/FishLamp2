//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFApiHttpPostGetDownloadOriginalKey.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/

/*
Creates a download original key for the provided list of photos.<A href="/Zenfolio/help/api/ref/methods/getdownloadoriginalkey">More...</A>
*/



@class ZFGetDownloadOriginalKeyHttpPostIn;

// --------------------------------------------------------------------
// ZFApiHttpPostGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface ZFApiHttpPostGetDownloadOriginalKey : NSObject{ 
@private
	ZFGetDownloadOriginalKeyHttpPostIn* _input;
	NSString* _output;
} 


@property (readwrite, retain, nonatomic) ZFGetDownloadOriginalKeyHttpPostIn* input;
// Getter will create _input if nil. Alternately, use the inputObject property, which will not lazy create it.

@property (readwrite, retain, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (ZFApiHttpPostGetDownloadOriginalKey*) apiHttpPostGetDownloadOriginalKey; 

@end

@interface ZFApiHttpPostGetDownloadOriginalKey (ValueProperties) 
@end


@interface ZFApiHttpPostGetDownloadOriginalKey (ObjectMembers) 

@property (readonly, retain, nonatomic) ZFGetDownloadOriginalKeyHttpPostIn* inputObject;
// This returns _input. It does NOT create it if it's NIL.

- (void) createInputIfNil; 
@end

