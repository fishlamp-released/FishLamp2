//
//	FLDataFile.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLStorableObject.h"
#import "FLWeaklyReferenced.h"

@class FLFolder;

@protocol FLAbstractFile <FLStorableObject, NSCopying, FLWeaklyReferenced> 
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

