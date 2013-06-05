//
//  FLCodeGeneratorResult.h
//  Whittle
//
//  Created by Mike Fullerton on 6/16/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLamp.h"

@interface FLCodeGeneratorResult : NSObject {
@private
	NSMutableArray* _addedFiles;
	NSMutableArray* _changedFiles;
	NSMutableArray* _unchangedFiles;
	NSMutableArray* _removedFiles;
}

+ (FLCodeGeneratorResult*) codeGeneratorResult;

@property (readonly, strong, nonatomic) NSArray* addedFiles;
@property (readonly, strong, nonatomic) NSArray* changedFiles;
@property (readonly, strong, nonatomic) NSArray* unchangedFiles;
@property (readonly, strong, nonatomic) NSArray* removedFiles;

- (void) addNewFile:(NSString*) newFile;
- (void) addChangedFile:(NSString*) changedFile;
- (void) addUnchangedFile:(NSString*) unchangedFile;
- (void) addRemovedFile:(NSString*) removedFile;

@end

