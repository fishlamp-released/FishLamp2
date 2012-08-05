// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLSoapFault11.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLSoapFault11
// --------------------------------------------------------------------
@interface FLSoapFault11 : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __faultcode;
    NSString* __faultstring;
    NSString* __faultactor;
    NSString* __detail;
} 


@property (readwrite, strong, nonatomic) NSString* detail;

@property (readwrite, strong, nonatomic) NSString* faultactor;

@property (readwrite, strong, nonatomic) NSString* faultcode;

@property (readwrite, strong, nonatomic) NSString* faultstring;

+ (NSString*) detailKey;

+ (NSString*) faultactorKey;

+ (NSString*) faultcodeKey;

+ (NSString*) faultstringKey;

+ (FLSoapFault11*) soapFault11; 

@end

@interface FLSoapFault11 (ValueProperties) 
@end

// [/Generated]
