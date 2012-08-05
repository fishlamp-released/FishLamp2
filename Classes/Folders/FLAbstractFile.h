//
//	FLDataFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLStorableObject.h"

@class FLFolder;

@protocol FLAbstractFile <FLStorableObject, NSCopying> 
@property (readwrite, retain, nonatomic) NSString* fileName;
@property (readwrite, retain, nonatomic) FLFolder* folder;
@property (readonly, retain, nonatomic) NSString* filePath;
@end

@interface FLAbstractFile : NSObject<FLAbstractFile> {
@private
	FLFolder* _folder;
	NSString* _fileName;
}
- (id) initWithFolder:(FLFolder*) folder fileName:(NSString*) fileName;

- (void) _throwIfNotConfigured;
@end

