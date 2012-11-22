// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookUpdateStatusOperation.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


#import "FLHttpOperation.h"
@class FLFacebookStatusMessage;

// --------------------------------------------------------------------
// FLFacebookUpdateStatusOperation
// --------------------------------------------------------------------
@interface FLFacebookUpdateStatusOperation : FLHttpOperation{ 
@private
    FLFacebookStatusMessage* __input;
    NSString* __output;
} 


@property (readwrite, strong, nonatomic) FLFacebookStatusMessage* input;

@property (readwrite, strong, nonatomic) NSString* output;

+ (NSString*) inputKey;

+ (NSString*) outputKey;

+ (FLFacebookUpdateStatusOperation*) facebookUpdateStatusOperation; 

@end

@interface FLFacebookUpdateStatusOperation (ValueProperties) 
@end

// [/Generated]
