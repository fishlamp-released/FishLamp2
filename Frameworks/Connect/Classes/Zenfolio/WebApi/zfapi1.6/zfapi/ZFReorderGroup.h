//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReorderGroup.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "ZFApi1_6Enums.h"

// --------------------------------------------------------------------
// ZFReorderGroup
// --------------------------------------------------------------------
@interface ZFReorderGroup : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _groupId;
	NSString* _shiftOrder;
} 


@property (readwrite, retain, nonatomic) NSNumber* groupId;

@property (readwrite, retain, nonatomic) NSString* shiftOrder;

+ (NSString*) groupIdKey;

+ (NSString*) shiftOrderKey;

+ (ZFReorderGroup*) reorderGroup; 

@end

@interface ZFReorderGroup (ValueProperties) 

@property (readwrite, assign, nonatomic) int groupIdValue;

@property (readwrite, assign, nonatomic) ZFGroupShiftOrder shiftOrderValue;
@end

