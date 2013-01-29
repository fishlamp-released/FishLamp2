//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfReorderPhotoSet.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "FLZfApi1_6Enums.h"

// --------------------------------------------------------------------
// FLZfReorderPhotoSet
// --------------------------------------------------------------------
@interface FLZfReorderPhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSString* _shiftOrder;
} 


@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) NSString* shiftOrder;

+ (NSString*) photoSetIdKey;

+ (NSString*) shiftOrderKey;

+ (FLZfReorderPhotoSet*) reorderPhotoSet; 

@end

@interface FLZfReorderPhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) FLZfShiftOrder shiftOrderValue;
@end

