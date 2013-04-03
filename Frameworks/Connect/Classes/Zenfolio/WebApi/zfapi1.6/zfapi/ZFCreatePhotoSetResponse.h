//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreatePhotoSetResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFCreatePhotoSetResponse
// --------------------------------------------------------------------
@interface ZFCreatePhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhotoSet* _CreatePhotoSetResult;
} 


@property (readwrite, retain, nonatomic) ZFPhotoSet* CreatePhotoSetResult;

+ (NSString*) CreatePhotoSetResultKey;

+ (ZFCreatePhotoSetResponse*) createPhotoSetResponse; 

@end

@interface ZFCreatePhotoSetResponse (ValueProperties) 
@end

