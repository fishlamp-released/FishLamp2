//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoSet.h
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
// FLZfLoadPhotoSet
// --------------------------------------------------------------------
@interface FLZfLoadPhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSString* _level;
	NSNumber* _includePhotos;
} 


@property (readwrite, retain, nonatomic) NSNumber* includePhotos;

@property (readwrite, retain, nonatomic) NSString* level;

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

+ (NSString*) includePhotosKey;

+ (NSString*) levelKey;

+ (NSString*) photoSetIdKey;

+ (FLZfLoadPhotoSet*) loadPhotoSet; 

@end

@interface FLZfLoadPhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) FLZfInformatonLevel levelValue;

@property (readwrite, assign, nonatomic) BOOL includePhotosValue;
@end

