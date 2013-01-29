//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFLoadPhotoSetResponse
// --------------------------------------------------------------------
@interface ZFLoadPhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhotoSet* _LoadPhotoSetResult;
} 


@property (readwrite, retain, nonatomic) ZFPhotoSet* LoadPhotoSetResult;

+ (NSString*) LoadPhotoSetResultKey;

+ (ZFLoadPhotoSetResponse*) loadPhotoSetResponse; 

@end

@interface ZFLoadPhotoSetResponse (ValueProperties) 
@end

