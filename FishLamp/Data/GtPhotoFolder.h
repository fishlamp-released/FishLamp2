//
//  GtPhotoFolder.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtFolder.h"

@interface GtPhotoFolder : GtFolder {
@private
	NSString* m_folderName;
}

@property (readonly, assign, nonatomic) NSString* folderName;

- (void) setFolderName:(NSString*) name 
            folderPath:(NSString*) folderPath;

- (void) loadPhotosInFolder:(NSArray**) outPhotoArray;

- (NSUInteger) countOriginalPhotos;

@end

