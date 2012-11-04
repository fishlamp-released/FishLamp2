//
//  FLTempFileMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/26/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLTempFileMgr.h"
#import "FLFolder.h"
#import "FLWeakReference.h"

#import <dispatch/dispatch.h>

@implementation FLTempFileMgr

@synthesize folder = _folder;
//FLSynthesizeSingleton(FLTempFileMgr);

//- (void) userSessionDidOpen:(id<FLUserSession>) userSession {
//    self.folder = [FLUserSession instance].tempFolder;
//
//// TODO: add this back
////    [[FLTempFileMgr instance] beginPurgeInBackgroundThread:nil];
//
//}
//
//- (void) userSessionDidClose:(id<FLUserSession>) userSession {
//// TODO: add this back
////    [[FLTempFileMgr instance] beginPurgeInBackgroundThread:nil];
//
//    self.folder = nil;
//}


- (id) init {
    if((self = [super init])) {
//        [[FLUserSession instance] addObserver:self];
    }
    
    return self;
}

- (void) dealloc {
    FLSendDeallocNotification();
//    [[FLUserSession instance] removeObserver:self];
    release_(_folder);
    super_dealloc_();
}

- (void) addFile:(id<FLAbstractFile>) file {
    @synchronized(self) {
        if(!_files) {
            _files = [[NSMutableDictionary alloc] init];
        }
        
        [_files setObject:[FLWeakReference weakReference:file] forKey:file.fileName];
    }
}

- (void) removeFile:(id<FLAbstractFile>) file {
    @synchronized(self) {
        [_files removeObjectForKey:file.fileName];
    }
}

- (BOOL) hasFile:(id<FLAbstractFile>) file {
    @synchronized(self) {
        FLWeakReference* ref = [_files objectForKey:file.fileName];
        return ref && ref.object; 
    }
    
    return NO;
}

- (void) setFolder:(FLFolder *)folder {
    @synchronized(self) {
        FLRetainObject_(_folder, folder);
        FLReleaseWithNil_(_files);
    }
}

- (void) _removeNilFiles {
    NSMutableArray* keysToDelete = nil;
    for(NSString* fileName in _files)
    {
        FLWeakReference* ref = [_files objectForKey:fileName];
        if(ref.isNil)
        {
            if(keysToDelete)
            {
                [keysToDelete addObject:fileName];
            }
            else
            {
                keysToDelete = [NSMutableArray arrayWithObject:fileName];
            }
        }
    }
    
    if(keysToDelete)
    {
        [_files removeObjectsForKeys:keysToDelete];
    }
}

- (void) beginPurgeInBackgroundThread:(dispatch_block_t)purgeComplete {
    @synchronized(self) {
        
        [self _removeNilFiles];
    
        if(purgeComplete) {
            purgeComplete = autorelease_([purgeComplete copy]);
        }
        
        dispatch_async(
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), 
            ^{
                @try {
                    [_folder deleteFiles:^(NSString* fileName, BOOL* shouldDeleteFile, BOOL* stop) {
                            @synchronized(self) {
                                FLWeakReference* ref = [_files objectForKey:fileName];
                                *shouldDeleteFile = (!ref || !ref.object);
                            }
                        }];
                
                }
                @catch(NSException* ex) {
                    FLDebugLog(@"Got error purging tempFolder: %@", [ex description]);
                }
        
                                
                if(purgeComplete) {
                    [self performBlockOnMainThread:purgeComplete];
                }
            });
    }
}

@end
