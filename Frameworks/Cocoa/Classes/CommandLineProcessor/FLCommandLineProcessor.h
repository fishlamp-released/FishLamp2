//
//  FLCommandLineProcessor.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/27/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCocoaRequired.h"
#import "FLStringFormatter.h"
#import "FLStringParser.h"
#import "FLToolCommand.h"

@interface FLCommandLineProcessor : NSObject {
@private
    NSMutableDictionary* _commands;
    FLLogger* _output;
}

@property (readonly, strong, nonatomic) NSDictionary* commands;
@property (readwrite, strong) FLLogger* output;

- (void) addToolCommand:(FLToolCommand*) command;

- (void) runToolCommandsWithInput:(NSString*) input;

// override point
- (void) handleEmptyInput;

@end

@interface NSFileManager (FLCommandLineProcessor)
- (void) openURL:(NSString *)url inBackground:(BOOL)background;
- (void) openFileInDefaultEditor:(NSString*) path;
@end


