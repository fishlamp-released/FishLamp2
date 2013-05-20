//
//  GtPhotoGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/10/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoGridViewCell.h"

@implementation GtPhotoGridViewCell

+ (GtPhotoGridViewCell*) photoGridViewCell:(id) gridViewObject
{
    return GtReturnAutoreleased([[GtPhotoGridViewCell alloc] initWithGridViewObject:gridViewObject]);
}

@end
