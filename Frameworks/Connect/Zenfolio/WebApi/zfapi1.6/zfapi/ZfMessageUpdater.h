//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMessageUpdater.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMessageUpdater
// --------------------------------------------------------------------
@interface ZFMessageUpdater : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFMessageUpdater*) messageUpdater; 

@end

@interface ZFMessageUpdater (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL IsPrivateValue;
@end

