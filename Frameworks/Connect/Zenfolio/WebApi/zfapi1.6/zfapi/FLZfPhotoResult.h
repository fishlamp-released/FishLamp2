//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfPhotoResult.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfPhoto;

// --------------------------------------------------------------------
// FLZfPhotoResult
// --------------------------------------------------------------------
@interface FLZfPhotoResult : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _Photos;
	NSNumber* _TotalCount;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* Photos;
// Type: FLZfPhoto*, forKey: Photo

@property (readwrite, retain, nonatomic) NSNumber* TotalCount;

+ (NSString*) PhotosKey;

+ (NSString*) TotalCountKey;

+ (FLZfPhotoResult*) photoResult; 

@end

@interface FLZfPhotoResult (ValueProperties) 

@property (readwrite, assign, nonatomic) int TotalCountValue;
@end

