//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetVersionResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfGetVersionResponse
// --------------------------------------------------------------------
@interface FLZfGetVersionResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetVersionResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetVersionResult;

+ (NSString*) GetVersionResultKey;

+ (FLZfGetVersionResponse*) getVersionResponse; 

@end

@interface FLZfGetVersionResponse (ValueProperties) 
@end

