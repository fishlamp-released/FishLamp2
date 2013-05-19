//
//  FLPhotoGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoGridViewCell.h"

@implementation FLPhotoGridViewCell

+ (FLPhotoGridViewCell*) photoGridViewCell:(id) dataRef {
    return FLAutorelease([[FLPhotoGridViewCell alloc] initWithDataRef:dataRef]);
}

@end
