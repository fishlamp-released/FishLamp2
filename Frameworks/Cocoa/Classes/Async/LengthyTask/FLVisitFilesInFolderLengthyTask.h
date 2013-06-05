//
//  FLVisitFilesInFolderLengthyTask.h
//  bump_build_version
//
//  Created by Mike Fullerton on 11/19/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLamp.h"

#import "FLLengthyTask.h"
#import "NSFileManager+FLExtras.h"

@interface FLVisitFilesInFolderLengthyTask : FLLengthyTask {
@private
    NSString* _startPath;
    FLFileManagerVisitor _visitorBlock;
}

- (id) initWithTaskName:(NSString*) taskName 
              startPath:(NSString*) startPath 
           visitorBlock:(FLFileManagerVisitor) visitorBlock;

+ (FLVisitFilesInFolderLengthyTask*) visitFilesInFolderLengthyTask:(NSString*) taskName 
              startPath:(NSString*) startPath 
           visitorBlock:(FLFileManagerVisitor) visitorBlock;
                                                       
@end    