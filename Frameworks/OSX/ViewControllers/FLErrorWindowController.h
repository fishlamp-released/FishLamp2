//
//  FLErrorWindowController.h
//  FishLampOSX
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Cocoa/Cocoa.h>

@interface FLErrorWindowController : NSWindowController {
@private
    IBOutlet NSTextField* _titleField;
    IBOutlet NSTextField* _explanationField;
    IBOutlet __unsafe_unretained NSButton* _okButton;
    NSString* _title;
    NSString* _explanation;

}
@property (readonly, assign, nonatomic) NSButton* okButton;

+ (id) errorWindowController:(NSString*) title explanation:(NSString*) explanation;

@end
