//
//	FLBase64Encoding.h
//	FishLamp
//
//	Created By Mike Fullerton on 4/23/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

@interface NSData (Base64Encoding)


- (NSData*) base64Decode; // returns autoreleased NSData
- (void) base64Encode:(NSData**) outData;

- (NSData*) base64Encode; // returns autoreleased NSData
- (void) base64Decode:(NSData**) outData;

// strings
- (void) base64EncodeToString:(NSString**) outString;
+ (void)base64DecodeString:(NSString*) str	outData:(NSData**) outData;

+ (void) concatAndEncodeSHA256:(NSData*) lhs rhs:(NSData*) rhs outData:(NSData**) outData;

@end

@interface NSString (Base64Encoding)

- (void) base64Encode:(NSString**) outString;
- (void) base64Decode:(NSString**) outString;

@end
