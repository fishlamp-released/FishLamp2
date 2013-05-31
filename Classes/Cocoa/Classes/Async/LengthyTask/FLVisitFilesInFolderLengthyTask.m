//
//  FLVisitFilesInFolderLengthyTask.m
//  bump_build_version
//
//  Created by Mike Fullerton on 11/19/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLVisitFilesInFolderLengthyTask.h"
#import "NSFileManager+FLExtras.h"

@interface FLVisitFilesInFolderLengthyTask ()
@property (readwrite, copy, nonatomic) FLFileManagerVisitor visitorBlock;
@property (readwrite, retain, nonatomic) NSString* startPath;
@end

@implementation FLVisitFilesInFolderLengthyTask

@synthesize startPath = _startPath;
@synthesize visitorBlock = _visitorBlock;

- (id) initWithTaskName:(NSString*) taskName 
              startPath:(NSString*) startPath 
           visitorBlock:(FLFileManagerVisitor) visitorBlock {
    if((self = [super init])) {
        self.taskName = taskName;
        self.startPath = startPath;
        self.visitorBlock = visitorBlock;
    }
    
    return self;
}

- (void) dealloc  {
    FLRelease(_startPath);
    FLRelease(_visitorBlock);
    FLSuperDealloc();
}

+ (FLVisitFilesInFolderLengthyTask*) visitFilesInFolderLengthyTask:(NSString*) taskName 
                                                         startPath:(NSString*) startPath 
                                                      visitorBlock:(FLFileManagerVisitor) visitorBlock {
    return FLAutorelease([[FLVisitFilesInFolderLengthyTask alloc] initWithTaskName:taskName startPath:startPath visitorBlock:visitorBlock]);
}        

- (NSUInteger) calculateTotalStepCount {
	return [[NSFileManager defaultManager] countItemsInDirectory:_startPath recursively:YES visibleItemsOnly:YES];
}

- (void) executeSelf {
    [[NSFileManager defaultManager] visitEachItemAtPath:_startPath recursively:YES visibleItemsOnly:YES visitor:
        ^(NSString* filePath, BOOL* stop) {

            if(_visitorBlock) {
                _visitorBlock(filePath, stop);
            }
            
            self.stepCount++;
        }];
    
	FLReleaseBlockWithNil(_visitorBlock);	
}                                               

@end 
