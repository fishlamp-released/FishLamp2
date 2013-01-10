//
//  FLToolCommand.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLToolCommand.h"

@implementation FLToolCommand

@synthesize options = _options;
@synthesize commandName = _commandName;
@synthesize subcommands = _subcommands;
@synthesize help = _help;

- (id) initWithCommandName:(NSString*) commandName {
    self = [super init];
    if(self) {
        _commandName = FLRetain(commandName);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_subcommands release];
    [_help release];
    [_commandName release];
    [_options release];
    [super dealloc];
}
#endif

- (FLToolCommandOption*) optionForKey:(NSString*) key {
    return [_options objectForKey:key];
}

- (void) addOption:(FLToolCommandOption*) option {
    for(NSString* key in option.optionKeys) {
        if(FLStringIsNotEmpty(key)) {
            id existing = [_options objectForKey:[key lowercaseString]];
            FLConfirmIsNil_v(existing, @"option already installed for key: %@", key);
            [_options setObject:option forKey:key];
        }
    }
}

- (NSDictionary*) parseOptions:(FLParseableInput*) input {

    NSMutableDictionary* options = [NSMutableDictionary dictionary];

    NSString* key = [input last];
    while(key) {
        FLToolCommandOption* option = [_options objectForKey:key];
        FLConfirmNotNil_v(option, @"Unknown option: %@", key);
        
        id data = [option parseOptionData:input siblings:self.options];
        if(!data) {
            data = [NSNull null];
        }
        
        [options setObject:data forKey:key];

        key = [input next];
    }
    
    return options;
}

- (void) runCommandWithOptions:(NSDictionary*) options output:(FLStringFormatter*) output {
}


- (void) addSubcommand:(FLToolCommand *)command {
    if(!_subcommands) {
        _subcommands = [[NSMutableDictionary alloc] init];
    }
    
    [_subcommands setObject:command forKey:[command.commandName lowercaseString]];
}

- (void) parseInput:(FLParseableInput*) input {

    NSString* key = [input next];
    NSDictionary* options = nil;
    
    if(key) {
        FLToolCommand* command = [_subcommands objectForKey:[key lowercaseString]];
        if(command) {
            // if we have subcommand - we don't get executed - only the leaf most command does.
            [command parseInput:input];
            return;
        }

        options = [self parseOptions:input];
    }

    FLConfirm_v(input.last == nil, @"input still remains: %@", input.unparsed);

    [input addCommitBlock:^(FLStringFormatter* output){ 
        [self runCommandWithOptions:options output:output]; 
    }];
}

- (NSString*) buildUsageString {
    return nil; // [NSString concatStringArray:self.optionKeys.allObjects];
}

- (void) printHelpToStringFormatter:(FLStringFormatter*) output {
//    [output appendLineWithFormat:@"@: %@", [[NSString concatStringArray:self.argumentKeys.allObjects] stringWithPadding:20], [self help]];
}


@end
