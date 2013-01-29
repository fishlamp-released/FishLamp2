//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMessage.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFMessage
// --------------------------------------------------------------------
@interface ZFMessage : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _MailboxId;
	NSNumber* _Index;
	NSDate* _PostedOn;
	NSString* _PosterName;
	NSString* _PosterLoginNane;
	NSString* _PosterUrl;
	NSString* _PosterEmail;
	NSString* _Body;
	NSNumber* _IsPrivate;
} 


@property (readwrite, retain, nonatomic) NSString* Body;

@property (readwrite, retain, nonatomic) NSNumber* Index;

@property (readwrite, retain, nonatomic) NSNumber* IsPrivate;

@property (readwrite, retain, nonatomic) NSString* MailboxId;

@property (readwrite, retain, nonatomic) NSDate* PostedOn;

@property (readwrite, retain, nonatomic) NSString* PosterEmail;

@property (readwrite, retain, nonatomic) NSString* PosterLoginNane;

@property (readwrite, retain, nonatomic) NSString* PosterName;

@property (readwrite, retain, nonatomic) NSString* PosterUrl;

+ (NSString*) BodyKey;

+ (NSString*) IndexKey;

+ (NSString*) IsPrivateKey;

+ (NSString*) MailboxIdKey;

+ (NSString*) PostedOnKey;

+ (NSString*) PosterEmailKey;

+ (NSString*) PosterLoginNaneKey;

+ (NSString*) PosterNameKey;

+ (NSString*) PosterUrlKey;

+ (ZFMessage*) message; 

@end

@interface ZFMessage (ValueProperties) 

@property (readwrite, assign, nonatomic) int IndexValue;

@property (readwrite, assign, nonatomic) BOOL IsPrivateValue;
@end

