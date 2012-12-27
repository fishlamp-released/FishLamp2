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

@interface FLTempFileMgr ()
@property (readwrite, strong) FLFolder* folder;
@end

@implementation FLTempFileMgr

@synthesize folder = _folder;


- (void) openService:(FLSession*) session {
//    self.folder = [self.context storageService].tempFolder;
    [self beginPurgeInBackgroundThread:nil];
}

- (void) closeService:(FLSession*) session {
    [self beginPurgeInBackgroundThread:nil];
    self.folder = nil;
}

- (id) initWithFolder:(FLFolder*) folder {
    if((self = [super init])) {
        self.folder = folder;
    }
    
    return self;
}


#if FL_MRC
- (void) dealloc {

    [_folder release];
    [super dealloc];
}
#endif

- (void) addFile:(id) file fileName:(NSString*) fileName {
    @synchronized(self) {
        if(!_files) {
            _files = [[NSMutableDictionary alloc] init];
        }
        
        [_files setObject:file forKey:fileName];
    }
}

- (void) removeFile:(NSString*) fileName {
    @synchronized(self) {
        [_files removeObjectForKey:fileName];
    }
}

- (BOOL) hasFile:(NSString*) fileName {
    return [_files objectForKey:fileName] != nil;
}

- (void) _removeNilFiles {
    NSMutableArray* keysToDelete = nil;
    for(NSString* fileName in _files) {
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
            purgeComplete = FLAutorelease([purgeComplete copy]);
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
