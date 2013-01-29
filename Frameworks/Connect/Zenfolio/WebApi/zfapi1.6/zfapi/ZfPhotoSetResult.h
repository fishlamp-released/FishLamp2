//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhotoSetResult.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFPhotoSet;

// --------------------------------------------------------------------
// ZFPhotoSetResult
// --------------------------------------------------------------------
@interface ZFPhotoSetResult : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _PhotoSets;
	NSNumber* _TotalCount;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* PhotoSets;
// Type: ZFPhotoSet*, forKey: PhotoSet

@property (readwrite, retain, nonatomic) NSNumber* TotalCount;

+ (NSString*) PhotoSetsKey;

+ (NSString*) TotalCountKey;

+ (ZFPhotoSetResult*) photoSetResult; 

@end

@interface ZFPhotoSetResult (ValueProperties) 

@property (readwrite, assign, nonatomic) int TotalCountValue;
@end

