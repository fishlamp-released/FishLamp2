//
//  FLStorageService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLService.h"
#import "FLObjectStorage.h"
#import "FLBlobStorage.h"

@interface FLStorageService : FLService<FLObjectStorage> {
@private
}

// required override.
- (id<FLObjectStorage>) objectStorage;
- (id<FLBlobStorage>) blobStorage;

@end

