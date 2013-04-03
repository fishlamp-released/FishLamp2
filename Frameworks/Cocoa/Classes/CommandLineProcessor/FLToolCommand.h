//
//  FLToolCommand.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStringParser.h"
#import "FLStringFormatter.h"
#import "FLToolCommandOption.h"
#import "FLBlockQueue.h"

@interface FLToolCommand : NSObject {
@private
    NSString* _commandName;
    NSMutableDictionary* _subcommands;
    NSMutableDictionary* _options;
    NSString* _help;
    __unsafe_unretained id _parent; 
}
@property (readonly, assign, nonatomic) id parent;
@property (readonly, strong, nonatomic) FLLogger* output;
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

- (void) parseInput:(FLStringParser*) input commitQueue:(FLBlockQueue*) commitQueue;

// override point
- (void) runCommandWithOptions:(NSDictionary*) options;

// optional overrides
- (NSString*) buildUsageString;
- (void) printHelpToStringFormatter:(FLStringFormatter*) output;


@end