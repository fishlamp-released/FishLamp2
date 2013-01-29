//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetVisitorKeyResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFGetVisitorKeyResponse
// --------------------------------------------------------------------
@interface ZFGetVisitorKeyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetVisitorKeyResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetVisitorKeyResult;

+ (NSString*) GetVisitorKeyResultKey;

+ (ZFGetVisitorKeyResponse*) getVisitorKeyResponse; 

@end

@interface ZFGetVisitorKeyResponse (ValueProperties) 
@end

