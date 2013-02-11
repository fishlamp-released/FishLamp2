//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetDownloadOriginalKeyHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioGetDownloadOriginalKeyHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioGetDownloadOriginalKeyHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _photoIds;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSMutableArray* photoIds;
// Type: NSString*, forKey: String

+ (NSString*) passwordKey;

+ (NSString*) photoIdsKey;

+ (FLZenfolioGetDownloadOriginalKeyHttpGetIn*) getDownloadOriginalKeyHttpGetIn; 

@end

@interface FLZenfolioGetDownloadOriginalKeyHttpGetIn (ValueProperties) 
@end

