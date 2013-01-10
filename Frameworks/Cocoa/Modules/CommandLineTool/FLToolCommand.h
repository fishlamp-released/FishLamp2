//
//  FLToolCommand.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParseableInput.h"
#import "FLStringFormatter.h"
#import "FLToolCommandOption.h"

@interface FLToolCommand : NSObject {
@private
    NSString* _commandName;
    NSMutableDictionary* _subcommands;
    NSMutableDictionary* _options;
    NSString* _help;
}

@property (readonly, strong, nonatomic) NSString* commandName;
@property (readonly, strong, nonatomic) NSDictionary* options;
@property (readonly, strong, nonatomic) NSDictionary* subcommands;

@property (readwrite, strong, nonatomic) NSString* help;

- (id) initWithCommandName:(NSString*) command;

// subcommands
- (void) addSubcommand:(FLToolCommand*) command;

// options
- (void) addOption:(FLToolCommandOption*) option;
- (FLToolCommandOption*) optionForKey:(NSString*) key;

- (void) parseInput:(FLParseableInput*) input;

// override point
- (void) runCommandWithOptions:(NSDictionary*) options output:(FLStringFormatter*) output;

// optional overrides
- (NSString*) buildUsageString;
- (void) printHelpToStringFormatter:(FLStringFormatter*) output;


@end