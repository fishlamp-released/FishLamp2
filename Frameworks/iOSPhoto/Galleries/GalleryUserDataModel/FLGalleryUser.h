//
//  FLGalleryUser.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLGalleryUser <NSObject>
@property (readonly, strong, nonatomic) NSString* displayName;
@end