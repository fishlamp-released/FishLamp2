//
//	GtSimpleTextEditViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtEditObjectViewController.h"

typedef enum {
	GtSimpleTextEditViewControllerModeSingleLine,
	GtSimpleTextEditViewControllerModeMultiLine
} GtSimpleTextEditViewControllerMode;

@interface GtSimpleTextEditViewController : GtEditObjectViewController {
	GtSimpleTextEditViewControllerMode m_mode;
}

- (id) initWithPrompt:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(GtSimpleTextEditViewControllerMode) mode;

+ (GtSimpleTextEditViewController*) simpleTextEditViewController:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(GtSimpleTextEditViewControllerMode) mode;

@property (readonly, retain, nonatomic) NSString* editedText;

@end
