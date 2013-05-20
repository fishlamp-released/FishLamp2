//
//  GtPhotoData.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/25/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtPhotoFile.h"

@class GtPhotoFolder;

@interface GtPhotoData : GtPhotoFile {
@private
	UIImage* m_image;
    CGSize m_dimensions;
}

@property (readwrite, assign, nonatomic) UIImage* image;

@property (readonly, assign, nonatomic) CGSize dimensions; // will return empty if image never loaded
@property (readonly, assign, nonatomic) BOOL isLoaded;
@property (readonly, assign, nonatomic) BOOL hasImage;
@property (readonly, assign, nonatomic) BOOL hasImageAndData;

- (id) initWithImage:(UIImage*) image;

- (void) setImageFromData;
- (void) setDataFromImage;

- (void) releaseImage;
- (void) releaseImageAndData;

- (void) createCustomSize:(GtPhotoData*) originalImageFile
	longSide:(NSUInteger) longSide
	makeSquare:(BOOL) makeSquare;

+ (void) convertImageToData:(UIImage*) image 
                    outData:(NSData**) outData;

@end
