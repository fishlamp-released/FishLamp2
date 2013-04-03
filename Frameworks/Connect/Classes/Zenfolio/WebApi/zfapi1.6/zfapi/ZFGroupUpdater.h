//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGroupUpdater.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFGroupUpdater
// --------------------------------------------------------------------
@interface ZFGroupUpdater : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _Title;
	NSString* _Caption;
	NSString* _CustomReference;
} 


@property (readwrite, retain, nonatomic) NSString* Caption;

@property (readwrite, retain, nonatomic) NSString* CustomReference;

@property (readwrite, retain, nonatomic) NSString* Title;

+ (NSString*) CaptionKey;

+ (NSString*) CustomReferenceKey;

+ (NSString*) TitleKey;

+ (ZFGroupUpdater*) groupUpdater; 

@end

@interface ZFGroupUpdater (ValueProperties) 
@end

