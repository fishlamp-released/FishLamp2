//
//  FLImageProperties.h
//  Composer
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "__FLCachedImageBaseClass.h"
#import "FLCachedImageBaseClass.h"

@interface FLImageProperties : FLCachedImageBaseClass {
@private
}

@property (readwrite, strong, nonatomic) NSURL* imageURL;

- (id) initWithImageURL:(NSURL*) url;
+ (id) imagePropertiesWithImageURL:(NSURL*) imageURL;
+ (id) imageProperties;

@end