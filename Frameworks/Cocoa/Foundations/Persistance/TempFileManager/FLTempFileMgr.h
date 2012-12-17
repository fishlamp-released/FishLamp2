//
//  FLTempFileMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/26/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"
#import "FLAbstractFile.h"
#import "FLService.h"
#import "FLFolder.h"

@interface FLTempFileMgr : FLService {
@private    
    NSMutableDictionary* _files;
    FLFolder* _folder;
}

- (id) initWithFolder:(FLFolder*) folder;

@property (readonly, strong) FLFolder* folder;

- (void) addFile:(id) file fileName:(NSString*) fileName;

- (void) removeFile:(NSString*) fileName;

- (BOOL) hasFile:(NSString*) fileName;

- (void) beginPurgeInBackgroundThread:(dispatch_block_t) purgeComplete;

@end
