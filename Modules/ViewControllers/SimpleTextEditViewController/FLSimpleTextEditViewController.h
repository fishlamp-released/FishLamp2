//
//	FLSimpleTextEditViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/30/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLEditObjectViewController.h"

typedef enum {
	FLSimpleTextEditViewControllerModeSingleLine,
	FLSimpleTextEditViewControllerModeMultiLine
} FLSimpleTextEditViewControllerMode;

@interface FLSimpleTextEditViewController : FLEditObjectViewController {
	FLSimpleTextEditViewControllerMode _mode;
}

- (id) initWithPrompt:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(FLSimpleTextEditViewControllerMode) mode;

+ (FLSimpleTextEditViewController*) simpleTextEditViewController:(NSString*) prompt value:(NSString*) value helpPrompt:(NSString*) helpPrompt editMode:(FLSimpleTextEditViewControllerMode) mode;

@property (readonly, retain, nonatomic) NSString* editedText;

@end
