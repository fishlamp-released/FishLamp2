//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateFavoritesSetResponse.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCreateFavoritesSetResponse
// --------------------------------------------------------------------
@interface ZFCreateFavoritesSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CreateFavoritesSetResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CreateFavoritesSetResult;

+ (NSString*) CreateFavoritesSetResultKey;

+ (ZFCreateFavoritesSetResponse*) createFavoritesSetResponse; 

@end

@interface ZFCreateFavoritesSetResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int CreateFavoritesSetResultValue;
@end
