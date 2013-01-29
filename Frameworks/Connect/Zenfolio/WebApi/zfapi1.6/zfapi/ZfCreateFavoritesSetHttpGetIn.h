//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateFavoritesSetHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFCreateFavoritesSetHttpGetIn
// --------------------------------------------------------------------
@interface ZFCreateFavoritesSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _name;
	NSString* _photographerLogin;
	NSMutableArray* _photoIds;
} 


@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSMutableArray* photoIds;
// Type: NSString*, forKey: String

@property (readwrite, retain, nonatomic) NSString* photographerLogin;

+ (NSString*) nameKey;

+ (NSString*) photoIdsKey;

+ (NSString*) photographerLoginKey;

+ (ZFCreateFavoritesSetHttpGetIn*) createFavoritesSetHttpGetIn; 

@end

@interface ZFCreateFavoritesSetHttpGetIn (ValueProperties) 
@end

