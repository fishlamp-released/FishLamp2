//
//	GtBase64Encoding.h
//	FishLamp
//
//	Created By Mike Fullerton on 4/23/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

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
