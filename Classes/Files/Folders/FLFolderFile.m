//
//	FLFolderFile.m
//	PackMule
//
//	Created by Mike Fullerton on 11/8/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLFolderFile.h"
#import "FLObjectDescriber.h"

@implementation FLFolderFile

@synthesize folder = _folder;
@synthesize fileName = _fileName;

- (id) initWithFolder:(FLFolder*) folder 
             fileName:(NSString*) fileName {
	if((self = [super init])) {
		self.folder = folder;
		self.fileName = fileName;
	}
	return self;
}

- (void) dealloc {
	FLRelease(_fileName);
	FLRelease(_folder);
	FLSuperDealloc();
}

- (NSString*) filePath {
	return [_folder pathForFile:self.fileName];
}

- (void) deleteFile {
	[_folder deleteFile:self.fileName];
}

- (void) writeToFile {
	[_folder writeObjectToFile:self.fileName object:self];
}

- (BOOL) fileExists {
	return [_folder fileExistsInFolder:self.fileName];
}

- (BOOL) readFromFile {
	@try {
		if([_folder fileExistsInFolder:self.fileName])
		{
			id contents = [_folder readObjectFromFile:self.fileName];
			
            if(contents)
            {
                FLMergeObjects(self, contents, FLMergeModeSourceWins);
            }
			
			return YES;
		}
	}
	@catch(NSException* ex) {
		FLDebugLog(@"exception loading folderFile: %@", [ex description]);
	}
	
	return NO;
}

@end
