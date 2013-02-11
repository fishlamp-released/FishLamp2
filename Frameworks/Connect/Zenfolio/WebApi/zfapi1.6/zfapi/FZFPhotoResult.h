//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhotoResult.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioPhotoResult
// --------------------------------------------------------------------
@interface FLZenfolioPhotoResult : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _Photos;
	NSNumber* _TotalCount;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* Photos;
// Type: FLZenfolioPhoto*, forKey: Photo

@property (readwrite, retain, nonatomic) NSNumber* TotalCount;

+ (NSString*) PhotosKey;

+ (NSString*) TotalCountKey;

+ (FLZenfolioPhotoResult*) photoResult; 

@end

@interface FLZenfolioPhotoResult (ValueProperties) 

@property (readwrite, assign, nonatomic) int TotalCountValue;
@end

