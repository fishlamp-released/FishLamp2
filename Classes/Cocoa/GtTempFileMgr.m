//
//  GtTempFileMgr.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/26/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTempFileMgr.h"
#import "GtFolder.h"

#import <dispatch/dispatch.h>

@implementation GtTempFileMgr

@synthesize folder = m_folder;
GtSynthesizeSingleton(GtTempFileMgr);

- (id) init
{
    if((self = [super init]))
    {
    }
    
    return self;
}

- (void) addFile:(id<GtAbstractFile>) file
{
    @synchronized(self) {
        if(!m_files)
        {
            m_files = [[NSMutableDictionary alloc] init];
        }
        
        [m_files setObject:[GtWeakReference weakReference:file] forKey:file.fileName];
    }
}

- (void) removeFile:(id<GtAbstractFile>) file
{
    @synchronized(self) {
        [m_files removeObjectForKey:file.fileName];
    }
}

- (BOOL) hasFile:(id<GtAbstractFile>) file
{
    @synchronized(self) {
        GtWeakReference* ref = [m_files objectForKey:file.fileName];
        return ref && ref.object; 
    }
    
    return NO;
}

- (void) setFolder:(GtFolder *)folder
{
    @synchronized(self) {
        GtAssignObject(m_folder, folder);
        GtReleaseWithNil(m_files);
    }
}

- (void) _removeNilFiles
{
    NSMutableArray* keysToDelete = nil;
    for(NSString* fileName in m_files)
    {
        GtWeakReference* ref = [m_files objectForKey:fileName];
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
        [m_files removeObjectsForKeys:keysToDelete];
    }
}

- (void) invokePurgeCompleteOnMainThread:(GtBlock)purgeComplete
{
    if(purgeComplete)
    {
        purgeComplete();
    }
}

- (void) beginPurgeInBackgroundThread:(GtBlock)purgeComplete
{
    @synchronized(self) {
        
        [self _removeNilFiles];
    
        if(purgeComplete)
        {
            purgeComplete = GtReturnAutoreleased([purgeComplete copy]);
        }
        
        dispatch_async(
            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), 
            ^{
                @try {
                    [m_folder deleteFiles:nil shouldDeleteFileBlock:^(NSString* fileName, BOOL* shouldDeleteFile) {
                            @synchronized(self) {
                                GtWeakReference* ref = [m_files objectForKey:fileName];
                                *shouldDeleteFile = (!ref || !ref.object);
                            }
                        }];
                
                }
                @catch(NSException* ex) {
                    GtLog(@"Got error purging tempFolder: %@", [ex description]);
                }
        
                                
                if(purgeComplete)
                {
                    [self performSelectorOnMainThread:@selector(invokePurgeCompleteOnMainThread:) withObject:purgeComplete  waitUntilDone:NO];
                }
            });
    }
}

@end
