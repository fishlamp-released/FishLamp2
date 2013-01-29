//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhotoResult.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhoto;

// --------------------------------------------------------------------
// ZFPhotoResult
// --------------------------------------------------------------------
@interface ZFPhotoResult : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _Photos;
	NSNumber* _TotalCount;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* Photos;
// Type: ZFPhoto*, forKey: Photo

@property (readwrite, retain, nonatomic) NSNumber* TotalCount;

+ (NSString*) PhotosKey;

+ (NSString*) TotalCountKey;

+ (ZFPhotoResult*) photoResult; 

@end

@interface ZFPhotoResult (ValueProperties) 

@property (readwrite, assign, nonatomic) int TotalCountValue;
@end

