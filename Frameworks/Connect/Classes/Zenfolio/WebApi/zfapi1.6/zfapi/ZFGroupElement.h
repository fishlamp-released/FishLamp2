//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGroupElement.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class ZFAccessDescriptor;

// --------------------------------------------------------------------
// ZFGroupElement
// --------------------------------------------------------------------
@interface ZFGroupElement : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Id;
	NSNumber* _GroupIndex;
	NSString* _Title;
	ZFAccessDescriptor* _AccessDescriptor;
	NSString* _Owner;
	NSNumber* _HideBranding;
} 


@property (readwrite, retain, nonatomic) ZFAccessDescriptor* AccessDescriptor;

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

+ (ZFGroupElement*) groupElement; 

@end

@interface ZFGroupElement (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;

@property (readwrite, assign, nonatomic) int GroupIndexValue;

@property (readwrite, assign, nonatomic) BOOL HideBrandingValue;
@end

