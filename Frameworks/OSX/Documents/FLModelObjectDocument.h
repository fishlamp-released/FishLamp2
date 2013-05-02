//
//  FLModelObjectDocument.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 5/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLModelObject.h"

@interface FLModelObjectDocument : NSDocument {
@private
    id _modelObject;
}
@property (readwrite, strong, nonatomic) id modelObject;

@end
