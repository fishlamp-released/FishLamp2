//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetRecentPhotosResponse.h
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
// ZFGetRecentPhotosResponse
// --------------------------------------------------------------------
@interface ZFGetRecentPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetRecentPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetRecentPhotosResult;
// Type: ZFPhoto*, forKey: Photo

+ (NSString*) GetRecentPhotosResultKey;

+ (ZFGetRecentPhotosResponse*) getRecentPhotosResponse; 

@end

@interface ZFGetRecentPhotosResponse (ValueProperties) 
@end

