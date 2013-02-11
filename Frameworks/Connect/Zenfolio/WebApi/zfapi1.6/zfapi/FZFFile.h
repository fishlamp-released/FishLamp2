//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioFile.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioFile
// --------------------------------------------------------------------
@interface FLZenfolioFile : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Id;
	NSNumber* _Width;
	NSNumber* _Height;
	NSString* _Sequence;
	NSString* _MimeType;
	NSString* _UrlCore;
	NSString* _UrlHost;
} 


@property (readwrite, retain, nonatomic) NSNumber* Height;

@property (readwrite, retain, nonatomic) NSNumber* Id;

@property (readwrite, retain, nonatomic) NSString* MimeType;

@property (readwrite, retain, nonatomic) NSString* Sequence;

@property (readwrite, retain, nonatomic) NSString* UrlCore;

@property (readwrite, retain, nonatomic) NSString* UrlHost;

@property (readwrite, retain, nonatomic) NSNumber* Width;

+ (NSString*) HeightKey;

+ (NSString*) IdKey;

+ (NSString*) MimeTypeKey;

+ (NSString*) SequenceKey;

+ (NSString*) UrlCoreKey;

+ (NSString*) UrlHostKey;

+ (NSString*) WidthKey;

+ (FLZenfolioFile*) file; 

@end

@interface FLZenfolioFile (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;

@property (readwrite, assign, nonatomic) unsigned int WidthValue;

@property (readwrite, assign, nonatomic) unsigned int HeightValue;
@end

