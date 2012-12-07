//
//  FLPhotoGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/10/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPhotoGridViewCell.h"

@implementation FLPhotoGridViewCell

+ (FLPhotoGridViewCell*) photoGridViewCell:(id) dataRef {
    return FLAutorelease([[FLPhotoGridViewCell alloc] initWithDataRef:dataRef]);
}

@end
