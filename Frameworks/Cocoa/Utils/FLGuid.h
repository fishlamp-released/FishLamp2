//
//	FLGuid.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCore.h"

#import "NSString+GUID.h"

@interface FLGuid : NSObject<NSCopying, NSCoding> {
@private
	NSString* _guid;
}

+ (FLGuid*) emptyGuid;

+ (FLGuid*) guid;
+ (FLGuid*) guidWithNewGuid;
+ (FLGuid*) guidWithString:(NSString*) aGuidString;

- (id) init;
- (id) initWithGuidString:(NSString*) guid;
- (id) initWithNewGuid;

@property (readwrite, retain, nonatomic) NSString* guidString;

- (BOOL)isEqualToString:(NSString*) aString;
- (BOOL)isEqualToGuid:(FLGuid*) aGuid;

@end

NS_INLINE 
BOOL FLIsValidGuid(FLGuid* guid)
{
	return guid != nil && FLStringIsNotEmpty(guid.guidString);
}