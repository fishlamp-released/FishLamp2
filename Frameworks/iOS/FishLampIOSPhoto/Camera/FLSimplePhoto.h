//
//  FLSimplePhoto.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLSimplePhoto : NSObject {
@private
    UIImage* _image;
    NSDictionary* _exif;
    NSURL* _assetURL;
}

@property (readonly, strong, nonatomic) UIImage* image;
@property (readonly, strong, nonatomic) NSDictionary* exif;
@property (readonly, strong, nonatomic) NSURL* assetURL;

- (id) initWithImage:(UIImage*) image exif:(NSDictionary*) exif;
- (id) initWithImage:(UIImage*) image exif:(NSDictionary*) exif assetURL:(NSURL*) assetURL;

+ (FLSimplePhoto*) simplePhoto:(UIImage*) image exif:(NSDictionary*) exif;
+ (FLSimplePhoto*) simplePhoto:(UIImage*) image exif:(NSDictionary*) exif assetURL:(NSURL*) assetURL;

@end