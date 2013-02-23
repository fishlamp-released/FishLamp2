//
//  FLSoapDataEncoder.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSoapDataEncoder.h"

#import "FLDateMgr.h"
#import "FLStringUtils.h"
#import "FLBase64Encoding.h"
#import "FLColorUtilities.h"

@implementation FLSoapDataEncoder

FLSynthesizeSingleton(FLSoapDataEncoder);

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSString:(NSString*) string {
    return [string xmlEncode];
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc decodeNSStringFromString:(NSString*) string {
    return [string xmlDecode];
}

- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSDate:(NSDate*) date {
    return [[FLDateMgr instance] ISO8601DateToString:(NSDate*) date];
}

- (NSDate*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDateFromString:(NSString*) string {
    return [[FLDateMgr instance] ISO8601StringToDate:string];
}

- (NSData*) typeDesc:(FLTypeDesc*) typeDesc decodeNSDataFromString:(NSString*) string {
    return [string base64Decode];
}

// TODO: why is this UTF8??? 
- (NSString*) typeDesc:(FLTypeDesc*) typeDesc encodeStringWithNSData:(NSData*) data {
    return FLAutorelease([[NSString alloc] initWithBytes:[data bytes] 
                                    length:[data length] 
                                    encoding:NSUTF8StringEncoding]);
}




@end
