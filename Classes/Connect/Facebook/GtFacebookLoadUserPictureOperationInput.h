//	This file was generated at 7/3/11 2:38 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookLoadUserPictureOperationInput.h
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtFacebookLoadUserPictureOperationInput
// --------------------------------------------------------------------
@interface GtFacebookLoadUserPictureOperationInput : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_type;
	NSString* m_pictureSize;
} 


@property (readwrite, retain, nonatomic) NSString* pictureSize;

@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) pictureSizeKey;

+ (NSString*) typeKey;

+ (GtFacebookLoadUserPictureOperationInput*) facebookLoadUserPictureOperationInput; 

@end

@interface GtFacebookLoadUserPictureOperationInput (ValueProperties) 
@end

