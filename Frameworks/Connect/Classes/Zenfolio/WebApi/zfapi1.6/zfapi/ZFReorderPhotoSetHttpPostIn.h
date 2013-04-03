//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReorderPhotoSetHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFReorderPhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface ZFReorderPhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _shiftOrder;
} 


@property (readwrite, retain, nonatomic) NSString* photoSetId;

@property (readwrite, retain, nonatomic) NSString* shiftOrder;

+ (NSString*) photoSetIdKey;

+ (NSString*) shiftOrderKey;

+ (ZFReorderPhotoSetHttpPostIn*) reorderPhotoSetHttpPostIn; 

@end

@interface ZFReorderPhotoSetHttpPostIn (ValueProperties) 
@end

