//
//  GtVisitFilesInFolderLengthyTask.h
//  bump_build_version
//
//  Created by Mike Fullerton on 11/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLengthyTask.h"
#import "NSFileManager+GtExtras.h"

@interface GtVisitFilesInFolderLengthyTask : GtLengthyTask {
@private
    NSString* m_startPath;
    GtFileManagerVisitor m_visitorBlock;
}

- (id) initWithTaskName:(NSString*) taskName 
              startPath:(NSString*) startPath 
           visitorBlock:(GtFileManagerVisitor) visitorBlock;

+ (GtVisitFilesInFolderLengthyTask*) visitFilesInFolderLengthyTask:(NSString*) taskName 
              startPath:(NSString*) startPath 
           visitorBlock:(GtFileManagerVisitor) visitorBlock;
                                                       
@end    