//
//  FLBlocks.h
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import <dispatch/dispatch.h>
#import "FLCoreFlags.h"
#import "FLRequired.h"

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.



extern id FLCopyOrRetainObject(id src);

extern float FLTimeBlock (dispatch_block_t block);


