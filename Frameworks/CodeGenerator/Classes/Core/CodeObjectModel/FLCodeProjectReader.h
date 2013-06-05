//
//  FLCodeProjectReader.h
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"

#import "FLCodeObjectModel.h"
#import "FLCodeProjectLocation.h"
#import "FLCodeProject.h"

@protocol FLCodeProjectReader <NSObject>
- (BOOL) canReadProjectFromLocation:(FLCodeProjectLocation*) location;
- (FLCodeProject *) readProjectFromLocation:(FLCodeProjectLocation*) location;
@end

@interface FLCodeProjectReader : NSObject<FLCodeProjectReader> {
@private
    NSMutableArray* _fileReaders;
}
+ (id) codeProjectReader;

@property (readonly, strong) NSArray* fileReaders;
- (void) addFileReader:(id<FLCodeProjectReader>) fileReader;
@end
