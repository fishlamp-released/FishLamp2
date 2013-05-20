//
//	GtDataFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStorableObject.h"

@class GtFolder;

@protocol GtAbstractFile <GtStorableObject, NSCopying> 
@property (readwrite, retain, nonatomic) NSString* fileName;
@property (readwrite, retain, nonatomic) GtFolder* folder;
@property (readonly, retain, nonatomic) NSString* filePath;
@end

@interface GtAbstractFile : NSObject<GtAbstractFile> {
@private
	GtFolder* m_folder;
	NSString* m_fileName;
}
- (id) initWithFolder:(GtFolder*) folder fileName:(NSString*) fileName;

- (void) _throwIfNotConfigured;
@end

