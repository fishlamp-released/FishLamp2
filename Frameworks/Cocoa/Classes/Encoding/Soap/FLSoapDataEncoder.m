//
//  FLSoapDataEncoder.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/11/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSoapDataEncoder.h"

#import "FLDateMgr.h"
#import "FLStringUtils.h"
#import "FLBase64Encoding.h"
#import "FLColorUtilities.h"

@implementation FLSoapDataEncoder

FLSynthesizeSingleton(FLSoapDataEncoder);

//- (NSString*) encodeStringWithString:(NSString*) string {
//    return [string xmlEncode];
//}
//
//- (NSString*) decodeStringFromString:(NSString*) string {
//    return [string xmlDecode];
//}
//
//- (NSString*) encodeStringWithDate:(NSDate*) date {
//    return [[FLDateMgr instance] ISO8601DateToString:(NSDate*) date];
//}
//
//- (NSDate*) decodeDateFromString:(NSString*) string {
//    return [[FLDateMgr instance] ISO8601StringToDate:string];
//}
//
//- (NSData*) decodeDataFromString:(NSString*) string {
//    return [string base64Decode];
//}
//
//// TODO: why is this UTF8??? 
//- (NSString*) encodeStringWithData:(NSData*) data {
//    return FLAutorelease([[NSString alloc] initWithBytes:[data bytes] 
//                                    length:[data length] 
//                                    encoding:NSUTF8StringEncoding]);
//}
//



@end
