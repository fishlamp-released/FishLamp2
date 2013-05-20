//
//	GtFolderFile.h
//	PackMule
//
//	Created by Mike Fullerton on 11/8/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtFolder.h"

@interface GtFolderFile : NSObject {
@private
	NSString* m_fileName;
	GtFolder* m_folder;
}

- (id) initWithFolder:(GtFolder*) folder fileName:(NSString*) fileName;

@property (readwrite, retain, nonatomic) GtFolder* folder;
@property (readwrite, retain, nonatomic) NSString* fileName; 

@property (readonly, retain, nonatomic) NSString* filePath;

- (void) writeToFile;
- (BOOL) readFromFile;
- (void) deleteFile;
- (BOOL) fileExists;

@end