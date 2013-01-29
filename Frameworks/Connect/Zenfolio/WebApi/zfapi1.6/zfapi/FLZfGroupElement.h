//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGroupElement.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfAccessDescriptor;

// --------------------------------------------------------------------
// FLZfGroupElement
// --------------------------------------------------------------------
@interface FLZfGroupElement : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Id;
	NSNumber* _GroupIndex;
	NSString* _Title;
	FLZfAccessDescriptor* _AccessDescriptor;
	NSString* _Owner;
	NSNumber* _HideBranding;
} 


@property (readwrite, retain, nonatomic) FLZfAccessDescriptor* AccessDescriptor;

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

+ (FLZfGroupElement*) groupElement; 

@end

@interface FLZfGroupElement (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;

@property (readwrite, assign, nonatomic) int GroupIndexValue;

@property (readwrite, assign, nonatomic) BOOL HideBrandingValue;
@end

