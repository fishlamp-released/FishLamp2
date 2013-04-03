//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoSetResponse.h
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
// ZFUpdatePhotoSetResponse
// --------------------------------------------------------------------
@interface ZFUpdatePhotoSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhotoSet* _UpdatePhotoSetResult;
} 


@property (readwrite, retain, nonatomic) ZFPhotoSet* UpdatePhotoSetResult;

+ (NSString*) UpdatePhotoSetResultKey;

+ (ZFUpdatePhotoSetResponse*) updatePhotoSetResponse; 

@end

@interface ZFUpdatePhotoSetResponse (ValueProperties) 
@end

