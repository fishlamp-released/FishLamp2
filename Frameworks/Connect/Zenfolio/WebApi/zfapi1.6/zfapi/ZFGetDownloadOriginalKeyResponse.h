//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetDownloadOriginalKeyResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFGetDownloadOriginalKeyResponse
// --------------------------------------------------------------------
@interface ZFGetDownloadOriginalKeyResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _GetDownloadOriginalKeyResult;
} 


@property (readwrite, retain, nonatomic) NSString* GetDownloadOriginalKeyResult;

+ (NSString*) GetDownloadOriginalKeyResultKey;

+ (ZFGetDownloadOriginalKeyResponse*) getDownloadOriginalKeyResponse; 

@end

@interface ZFGetDownloadOriginalKeyResponse (ValueProperties) 
@end

