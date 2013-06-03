//
//	FLStillCamera.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0

#import <Foundation/Foundation.h>
#import "FLCamera.h"
typedef void (^FLCameraCapturePhotoBlock)(CMSampleBufferRef buffer, NSError* error);

@interface FLStillCamera : FLCamera {
@private
	AVCaptureStillImageOutput* _output;
}

- (void) captureImage:(FLCameraCapturePhotoBlock) block;

+ (NSDictionary*) exifDataFromBuffer:(CMSampleBufferRef) buffer;
+ (void) setExifDataInBuffer:(CMSampleBufferRef) buffer exif:(NSDictionary*) exif;

+ (void) convertToData:(CMSampleBufferRef) buffer outData:(NSData**) outData;

@end
#endif
#endif