//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetDownloadOriginalKey.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetDownloadOriginalKey
// --------------------------------------------------------------------
@interface FLZenfolioGetDownloadOriginalKey : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _photoIds;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSMutableArray* photoIds;
// Type: NSNumber*, forKey: int

+ (NSString*) passwordKey;

+ (NSString*) photoIdsKey;

+ (FLZenfolioGetDownloadOriginalKey*) getDownloadOriginalKey; 

@end

@interface FLZenfolioGetDownloadOriginalKey (ValueProperties) 
@end

