//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "FLZenfolioApi1_6Enums.h"

// --------------------------------------------------------------------
// FLZenfolioLoadPhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioLoadPhotoSet : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioLoadPhotoSet*) loadPhotoSet; 

@end

@interface FLZenfolioLoadPhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) FLZenfolioInformatonLevel levelValue;

@property (readwrite, assign, nonatomic) BOOL includePhotosValue;
@end

