//
//  FLSimplePhoto.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimplePhoto.h"

@interface FLSimplePhoto ()
@property (readwrite, strong, nonatomic) UIImage* image;
@property (readwrite, strong, nonatomic) NSDictionary* exif;
@property (readwrite, strong, nonatomic) NSURL* assetURL;
@end

@implementation FLSimplePhoto
@synthesize image = _image;
@synthesize exif = _exif;
@synthesize assetURL = _assetURL;

- (id) initWithImage:(UIImage*) image exif:(NSDictionary*) exif {
    return [self initWithImage:image exif:exif assetURL:nil];
}

- (id) initWithImage:(UIImage*) image exif:(NSDictionary*) exif  assetURL:(NSURL*) assetURL {
    self = [super init];
    if(self) {
        self.assetURL = assetURL;
        self.image = image;
        self.exif = exif;
    }
    return self;
}

+ (FLSimplePhoto*) simplePhoto:(UIImage*) image exif:(NSDictionary*) exif assetURL:(NSURL*) assetURL {
    return FLReturnAutoreleased([[FLSimplePhoto alloc] initWithImage:image exif:exif assetURL:assetURL]);
}

+ (FLSimplePhoto*) simplePhoto:(UIImage*) image exif:(NSDictionary*) exif {
    return FLReturnAutoreleased([[FLSimplePhoto alloc] initWithImage:image exif:exif assetURL:nil]);
}


#if FL_NO_ARC
- (void) dealloc {
    [_assetURL release];
    [_image release];
    [_exif release];
    [super dealloc];
}
#endif

@end
