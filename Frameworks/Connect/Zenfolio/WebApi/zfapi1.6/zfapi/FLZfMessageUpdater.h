//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfMessageUpdater.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfMessageUpdater
// --------------------------------------------------------------------
@interface FLZfMessageUpdater : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZfMessageUpdater*) messageUpdater; 

@end

@interface FLZfMessageUpdater (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL IsPrivateValue;
@end

