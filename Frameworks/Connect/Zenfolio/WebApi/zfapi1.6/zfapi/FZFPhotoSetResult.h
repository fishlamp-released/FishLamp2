//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhotoSetResult.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhotoSet;

// --------------------------------------------------------------------
// FLZenfolioPhotoSetResult
// --------------------------------------------------------------------
@interface FLZenfolioPhotoSetResult : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _PhotoSets;
	NSNumber* _TotalCount;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* PhotoSets;
// Type: FLZenfolioPhotoSet*, forKey: PhotoSet

@property (readwrite, retain, nonatomic) NSNumber* TotalCount;

+ (NSString*) PhotoSetsKey;

+ (NSString*) TotalCountKey;

+ (FLZenfolioPhotoSetResult*) photoSetResult; 

@end

@interface FLZenfolioPhotoSetResult (ValueProperties) 

@property (readwrite, assign, nonatomic) int TotalCountValue;
@end

