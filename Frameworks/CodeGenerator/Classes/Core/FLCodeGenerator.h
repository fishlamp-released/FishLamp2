//
//	FLCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 8/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FishLamp.h"

@class FLCodeProject;
@protocol FLCodeGeneratorFile;

@protocol FLCodeGenerator <NSObject>
- (void) generateCodeForProject:(FLCodeProject*) project;
@end

@protocol FLCodeGeneratorObserver <NSObject>
@optional
- (void) codeGenerator:(id) codeGenerator willBeginGeneratingWithProject:(FLCodeProject*) project;
- (void) codeGenerator:(id) codeGenerator didFinishGeneratingWithProject:(FLCodeProject*) project;
- (void) codeGenerator:(id) codeGenerator didFail:(FLCodeProject*) project;

- (void) codeGenerator:(id) codeGenerator didWriteNewFile:(id<FLCodeGeneratorFile>) file;
- (void) codeGenerator:(id) codeGenerator didUpdateFile:(id<FLCodeGeneratorFile>) file;
- (void) codeGenerator:(id) codeGenerator didSkipFile:(id<FLCodeGeneratorFile>) file;
- (void) codeGenerator:(id) codeGenerator didRemoveFile:(id<FLCodeGeneratorFile>) file;
@end

