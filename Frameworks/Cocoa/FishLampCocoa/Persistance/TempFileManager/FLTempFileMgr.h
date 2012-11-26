//
//  FLTempFileMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/26/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLAbstractFile.h"
#import "FLService.h"

@interface FLTempFileMgr : FLService {
@private    
    NSMutableDictionary* _files;
    FLFolder* _folder;
}

@property (readwrite, strong, nonatomic) FLFolder* folder;

- (void) addFile:(id<FLAbstractFile>) file;
- (void) removeFile:(id<FLAbstractFile>) file;
- (BOOL) hasFile:(id<FLAbstractFile>) file;

- (void) beginPurgeInBackgroundThread:(dispatch_block_t) purgeComplete;

@end
