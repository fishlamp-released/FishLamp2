//	This file was generated at 3/13/12 6:26 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSharedFavoritesSet.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// ZFSharedFavoritesSet
// --------------------------------------------------------------------
@interface ZFSharedFavoritesSet : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* _sharedFavoritesSetId;
	NSString* _sharerName;
	NSString* _sharerMessage;
	NSString* _sharerEmail;
	NSString* _photographerLogin;
	NSString* _favoritesSetName;
	NSMutableSet* _photoIds;
} 


@property (readwrite, retain, nonatomic) NSString* favoritesSetName;

@property (readwrite, retain, nonatomic) NSMutableSet* photoIds;

@property (readwrite, retain, nonatomic) NSString* photographerLogin;

@property (readwrite, retain, nonatomic) NSString* sharedFavoritesSetId;

@property (readwrite, retain, nonatomic) NSString* sharerEmail;

@property (readwrite, retain, nonatomic) NSString* sharerMessage;

@property (readwrite, retain, nonatomic) NSString* sharerName;

+ (NSString*) favoritesSetNameKey;

+ (NSString*) photoIdsKey;

+ (NSString*) photographerLoginKey;

+ (NSString*) sharedFavoritesSetIdKey;

+ (NSString*) sharerEmailKey;

+ (NSString*) sharerMessageKey;

+ (NSString*) sharerNameKey;

+ (ZFSharedFavoritesSet*) sharedFavoritesSet; 

@end

@interface ZFSharedFavoritesSet (ValueProperties) 
@end
