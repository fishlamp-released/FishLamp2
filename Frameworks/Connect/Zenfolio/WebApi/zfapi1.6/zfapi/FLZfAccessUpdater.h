//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAccessUpdater.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "FLZfApi1_6Enums.h"
#import "FLZfApi1_6Enums.h"

// --------------------------------------------------------------------
// FLZfAccessUpdater
// --------------------------------------------------------------------
@interface FLZfAccessUpdater : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _AccessMask;
	NSString* _Password;
	NSString* _AccessType;
	NSMutableArray* _Viewers;
	NSNumber* _IsDerived;
} 


@property (readwrite, retain, nonatomic) NSString* AccessMask;

@property (readwrite, retain, nonatomic) NSString* AccessType;

@property (readwrite, retain, nonatomic) NSNumber* IsDerived;

@property (readwrite, retain, nonatomic) NSString* Password;

@property (readwrite, retain, nonatomic) NSMutableArray* Viewers;
// Type: NSString*, forKey: Viewer

+ (NSString*) AccessMaskKey;

+ (NSString*) AccessTypeKey;

+ (NSString*) IsDerivedKey;

+ (NSString*) PasswordKey;

+ (NSString*) ViewersKey;

+ (FLZfAccessUpdater*) accessUpdater; 

@end

@interface FLZfAccessUpdater (ValueProperties) 

@property (readwrite, assign, nonatomic) FLZfApiAccessMask AccessMaskValue;

@property (readwrite, assign, nonatomic) FLZfAccessType AccessTypeValue;

@property (readwrite, assign, nonatomic) BOOL IsDerivedValue;
@end

