//
//  GtVisitFilesInFolderLengthyTask.m
//  bump_build_version
//
//  Created by Mike Fullerton on 11/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtVisitFilesInFolderLengthyTask.h"
#import "NSFileManager+GtExtras.h"

@interface GtVisitFilesInFolderLengthyTask ()
@property (readwrite, copy, nonatomic) GtFileManagerVisitor visitorBlock;
@property (readwrite, retain, nonatomic) NSString* startPath;
@end

@implementation GtVisitFilesInFolderLengthyTask

@synthesize startPath = m_startPath;
@synthesize visitorBlock = m_visitorBlock;

- (id) initWithTaskName:(NSString*) taskName 
              startPath:(NSString*) startPath 
           visitorBlock:(GtFileManagerVisitor) visitorBlock
{
    if((self = [super init]))
    {
        self.taskName = taskName;
        self.startPath = startPath;
        self.visitorBlock = visitorBlock;
    }
    
    return self;
}

- (void) dealloc 
{
    GtRelease(m_startPath);
    GtRelease(m_visitorBlock);
    GtSuperDealloc();
}

+ (GtVisitFilesInFolderLengthyTask*) visitFilesInFolderLengthyTask:(NSString*) taskName 
                                                         startPath:(NSString*) startPath 
                                                      visitorBlock:(GtFileManagerVisitor) visitorBlock
{
    return GtReturnAutoreleased([[GtVisitFilesInFolderLengthyTask alloc] initWithTaskName:taskName startPath:startPath visitorBlock:visitorBlock]);
}        

- (NSUInteger) calculateTotalStepCount
{
	return [[NSFileManager defaultManager] countItemsInDirectory:m_startPath recursively:YES visibleItemsOnly:YES];
}

- (void) doExecuteTask
{
    [[NSFileManager defaultManager] visitEachItemAtPath:m_startPath recursively:YES visibleItemsOnly:YES visitor:
        ^(NSString* filePath, BOOL* stop) {

            if(m_visitorBlock)
            {
                m_visitorBlock(filePath, stop);
            }
            
            [self incrementStep];
        }];
    
	GtReleaseBlockWithNil(m_visitorBlock);	
}                                               

@end 
