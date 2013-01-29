//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetRecentPhotosResponse.h
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
// FLZfGetRecentPhotosResponse
// --------------------------------------------------------------------
@interface FLZfGetRecentPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetRecentPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetRecentPhotosResult;
// Type: FLZfPhoto*, forKey: Photo

+ (NSString*) GetRecentPhotosResultKey;

+ (FLZfGetRecentPhotosResponse*) getRecentPhotosResponse; 

@end

@interface FLZfGetRecentPhotosResponse (ValueProperties) 
@end

