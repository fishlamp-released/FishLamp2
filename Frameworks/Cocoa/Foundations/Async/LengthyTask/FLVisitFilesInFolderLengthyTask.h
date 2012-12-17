//
//  FLVisitFilesInFolderLengthyTask.h
//  bump_build_version
//
//  Created by Mike Fullerton on 11/19/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

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