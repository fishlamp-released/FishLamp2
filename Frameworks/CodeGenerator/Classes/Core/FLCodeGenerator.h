//
//	FLCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 8/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLamp.h"
#import "FLObservable.h"

@class FLCodeProject;
@protocol FLCodeGeneratorFile;

@protocol FLCodeGenerator <FLObservable, NSObject>
- (void) generateCodeForProject:(FLCodeProject*) project;
@end

@protocol FLCodeGeneratorObserver <NSObject>
@optional
- (void) codeGenerator:(id) codeGenerator generationWillBeginForProject:(FLCodeProject*) project;
- (void) codeGenerator:(id) codeGenerator generationDidFinishForProject:(FLCodeProject*) project;
- (void) codeGenerator:(id) codeGenerator generationDidFailForProject:(FLCodeProject*) project withError:(NSError*) error;

- (void) codeGenerator:(id) codeGenerator didWriteNewFile:(id<FLCodeGeneratorFile>) file;
- (void) codeGenerator:(id) codeGenerator didUpdateFile:(id<FLCodeGeneratorFile>) file;
- (void) codeGenerator:(id) codeGenerator didSkipFile:(id<FLCodeGeneratorFile>) file;
- (void) codeGenerator:(id) codeGenerator didRemoveFile:(id<FLCodeGeneratorFile>) file;
@end

