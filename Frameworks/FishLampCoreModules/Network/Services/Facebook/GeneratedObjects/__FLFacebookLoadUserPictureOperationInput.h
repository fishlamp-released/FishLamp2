// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookLoadUserPictureOperationInput.h
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLFacebookLoadUserPictureOperationInput
// --------------------------------------------------------------------
@interface FLFacebookLoadUserPictureOperationInput : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __type;
    NSString* __pictureSize;
} 


@property (readwrite, strong, nonatomic) NSString* pictureSize;

@property (readwrite, strong, nonatomic) NSString* type;

+ (NSString*) pictureSizeKey;

+ (NSString*) typeKey;

+ (FLFacebookLoadUserPictureOperationInput*) facebookLoadUserPictureOperationInput; 

@end

@interface FLFacebookLoadUserPictureOperationInput (ValueProperties) 
@end

// [/Generated]
