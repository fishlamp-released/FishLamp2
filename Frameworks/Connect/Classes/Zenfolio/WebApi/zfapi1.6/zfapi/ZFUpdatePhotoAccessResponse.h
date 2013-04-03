//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFUpdatePhotoAccessResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFUpdatePhotoAccessResponse
// --------------------------------------------------------------------
@interface ZFUpdatePhotoAccessResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _UpdatePhotoAccessResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* UpdatePhotoAccessResult;

+ (NSString*) UpdatePhotoAccessResultKey;

+ (ZFUpdatePhotoAccessResponse*) updatePhotoAccessResponse; 

@end

@interface ZFUpdatePhotoAccessResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int UpdatePhotoAccessResultValue;
@end

