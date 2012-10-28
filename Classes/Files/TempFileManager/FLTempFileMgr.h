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

@interface FLTempFileMgr : NSObject {
@private    
    NSMutableDictionary* _files;
    FLFolder* _folder;
}

FLSingletonProperty(FLTempFileMgr);

@property (readwrite, strong, nonatomic) FLFolder* folder;

- (void) addFile:(id<FLAbstractFile>) file;
- (void) removeFile:(id<FLAbstractFile>) file;
- (BOOL) hasFile:(id<FLAbstractFile>) file;

- (void) beginPurgeInBackgroundThread:(dispatch_block_t) purgeComplete;

@end
