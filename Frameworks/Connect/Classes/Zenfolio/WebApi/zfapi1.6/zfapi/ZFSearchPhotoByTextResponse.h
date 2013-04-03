//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchPhotoByTextResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFPhotoResult;

// --------------------------------------------------------------------
// ZFSearchPhotoByTextResponse
// --------------------------------------------------------------------
@interface ZFSearchPhotoByTextResponse : NSObject<NSCoding, NSCopying>{ 
@private
	ZFPhotoResult* _SearchPhotoByTextResult;
} 


@property (readwrite, retain, nonatomic) ZFPhotoResult* SearchPhotoByTextResult;

+ (NSString*) SearchPhotoByTextResultKey;

+ (ZFSearchPhotoByTextResponse*) searchPhotoByTextResponse; 

@end

@interface ZFSearchPhotoByTextResponse (ValueProperties) 
@end

