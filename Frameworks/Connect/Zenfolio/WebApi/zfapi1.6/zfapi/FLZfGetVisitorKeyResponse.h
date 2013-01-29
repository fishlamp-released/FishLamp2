//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetVisitorKeyResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfGetVisitorKeyResponse
// --------------------------------------------------------------------
@interface FLZfGetVisitorKeyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetVisitorKeyResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetVisitorKeyResult;

+ (NSString*) GetVisitorKeyResultKey;

+ (FLZfGetVisitorKeyResponse*) getVisitorKeyResponse; 

@end

@interface FLZfGetVisitorKeyResponse (ValueProperties) 
@end

