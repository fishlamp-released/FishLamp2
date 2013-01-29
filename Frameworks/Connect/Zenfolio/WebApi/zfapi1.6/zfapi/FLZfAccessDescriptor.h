//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAccessDescriptor.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "FLDatabaseObject.h"
#import "FLZfApi1_6Enums.h"
#import "FLZfApi1_6Enums.h"

// --------------------------------------------------------------------
// FLZfAccessDescriptor
// --------------------------------------------------------------------
@interface FLZfAccessDescriptor : FLDatabaseObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _RealmId;
	NSString* _AccessType;
	NSNumber* _IsDerived;
	NSString* _AccessMask;
	NSMutableArray* _Viewers;
	NSString* _PasswordHint;
	NSString* _SrcPasswordHint;
	NSString* _protectedObjectClassName;
	NSString* _password;
} 


@property (readwrite, retain, nonatomic) NSString* AccessMask;

@property (readwrite, retain, nonatomic) NSString* AccessType;

@property (readwrite, retain, nonatomic) NSNumber* IsDerived;

@property (readwrite, retain, nonatomic) NSString* PasswordHint;

@property (readwrite, retain, nonatomic) NSNumber* RealmId;

@property (readwrite, retain, nonatomic) NSString* SrcPasswordHint;

@property (readwrite, retain, nonatomic) NSMutableArray* Viewers;
// Type: NSString*, forKey: Viewer

@property (readwrite, retain, nonatomic) NSString* password;

@property (readwrite, retain, nonatomic) NSString* protectedObjectClassName;

+ (NSString*) AccessMaskKey;

+ (NSString*) AccessTypeKey;

+ (NSString*) IsDerivedKey;

+ (NSString*) PasswordHintKey;

+ (NSString*) RealmIdKey;

+ (NSString*) SrcPasswordHintKey;

+ (NSString*) ViewersKey;

+ (NSString*) passwordKey;

+ (NSString*) protectedObjectClassNameKey;

+ (FLZfAccessDescriptor*) accessDescriptor; 

@end

@interface FLZfAccessDescriptor (ValueProperties) 

@property (readwrite, assign, nonatomic) int RealmIdValue;

@property (readwrite, assign, nonatomic) FLZfAccessType AccessTypeValue;

@property (readwrite, assign, nonatomic) BOOL IsDerivedValue;

@property (readwrite, assign, nonatomic) FLZfApiAccessMask AccessMaskValue;
@end

