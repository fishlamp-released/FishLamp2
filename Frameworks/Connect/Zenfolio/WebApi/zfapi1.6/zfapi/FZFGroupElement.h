//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGroupElement.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioAccessDescriptor;

// --------------------------------------------------------------------
// FLZenfolioGroupElement
// --------------------------------------------------------------------
@interface FLZenfolioGroupElement : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Id;
	NSNumber* _GroupIndex;
	NSString* _Title;
	FLZenfolioAccessDescriptor* _AccessDescriptor;
	NSString* _Owner;
	NSNumber* _HideBranding;
} 


@property (readwrite, retain, nonatomic) FLZenfolioAccessDescriptor* AccessDescriptor;

@property (readwrite, retain, nonatomic) NSNumber* GroupIndex;

@property (readwrite, retain, nonatomic) NSNumber* HideBranding;

@property (readwrite, retain, nonatomic) NSNumber* Id;

@property (readwrite, retain, nonatomic) NSString* Owner;

@property (readwrite, retain, nonatomic) NSString* Title;

+ (NSString*) AccessDescriptorKey;

+ (NSString*) GroupIndexKey;

+ (NSString*) HideBrandingKey;

+ (NSString*) IdKey;

+ (NSString*) OwnerKey;

+ (NSString*) TitleKey;

+ (FLZenfolioGroupElement*) groupElement; 

@end

@interface FLZenfolioGroupElement (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;

@property (readwrite, assign, nonatomic) int GroupIndexValue;

@property (readwrite, assign, nonatomic) BOOL HideBrandingValue;
@end

