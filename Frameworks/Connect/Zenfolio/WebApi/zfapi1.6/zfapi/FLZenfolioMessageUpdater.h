//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioMessageUpdater.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioMessageUpdater
// --------------------------------------------------------------------
@interface FLZenfolioMessageUpdater : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _PosterName;
	NSString* _PosterUrl;
	NSString* _PosterEmail;
	NSString* _Body;
	NSNumber* _IsPrivate;
} 


@property (readwrite, retain, nonatomic) NSString* Body;

@property (readwrite, retain, nonatomic) NSNumber* IsPrivate;

@property (readwrite, retain, nonatomic) NSString* PosterEmail;

@property (readwrite, retain, nonatomic) NSString* PosterName;

@property (readwrite, retain, nonatomic) NSString* PosterUrl;

+ (NSString*) BodyKey;

+ (NSString*) IsPrivateKey;

+ (NSString*) PosterEmailKey;

+ (NSString*) PosterNameKey;

+ (NSString*) PosterUrlKey;

+ (FLZenfolioMessageUpdater*) messageUpdater; 

@end

@interface FLZenfolioMessageUpdater (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL IsPrivateValue;
@end

