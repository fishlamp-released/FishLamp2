//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreatePhotoFromUrlResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCreatePhotoFromUrlResponse
// --------------------------------------------------------------------
@interface ZFCreatePhotoFromUrlResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CreatePhotoFromUrlResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CreatePhotoFromUrlResult;

+ (NSString*) CreatePhotoFromUrlResultKey;

+ (ZFCreatePhotoFromUrlResponse*) createPhotoFromUrlResponse; 

@end

@interface ZFCreatePhotoFromUrlResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int CreatePhotoFromUrlResultValue;
@end

