//
//  GtTempFileMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/26/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtAbstractFile.h"

@interface GtTempFileMgr : NSObject {
@private    
    NSMutableDictionary* m_files;
    GtFolder* m_folder;
}

GtSingletonProperty(GtTempFileMgr);

@property (readwrite, retain, nonatomic) GtFolder* folder;

- (void) addFile:(id<GtAbstractFile>) file;
- (void) removeFile:(id<GtAbstractFile>) file;
- (BOOL) hasFile:(id<GtAbstractFile>) file;

- (void) beginPurgeInBackgroundThread:(GtBlock) purgeComplete;

@end
