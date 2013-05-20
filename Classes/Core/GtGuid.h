//
//	GtGuid.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/16/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FishLampMinimum.h"

#import "NSString+GUID.h"
#import "GtStringUtils.h"
#import "GtStringUtils.h"

@interface GtGuid : NSObject<NSCopying, NSCoding> {
@private
	NSString* _guid;
}

+ (GtGuid*) emptyGuid;

+ (GtGuid*) guid;
+ (GtGuid*) guidWithNewGuid;
+ (GtGuid*) guidWithString:(NSString*) aGuidString;

- (id) init;
- (id) initWithGuidString:(NSString*) guid;
- (id) initWithNewGuid;

@property (readwrite, retain, nonatomic) NSString* guidString;

- (BOOL)isEqualToString:(NSString*) aString;
- (BOOL)isEqualToGuid:(GtGuid*) aGuid;

@end

NS_INLINE 
BOOL GtIsValidGuid(GtGuid* guid)
{
	return guid != nil && GtStringIsNotEmpty(guid.guidString);
}