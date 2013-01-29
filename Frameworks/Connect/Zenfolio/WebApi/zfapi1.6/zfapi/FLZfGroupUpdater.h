//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGroupUpdater.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfGroupUpdater
// --------------------------------------------------------------------
@interface FLZfGroupUpdater : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZfGroupUpdater*) groupUpdater; 

@end

@interface FLZfGroupUpdater (ValueProperties) 
@end

