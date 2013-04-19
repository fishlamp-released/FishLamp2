//
//  FLPanelViewController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

@class FLPanelManager;
@class FLPanelViewController;

@protocol FLPanelArea <NSObject>
- (SDKView*) contentView;

@optional
- (void) panelDidAppear:(FLPanelViewController*) panel;
- (void) panelWillAppear:(FLPanelViewController*) panel;
- (void) panelWillDisappear:(FLPanelViewController*) panel;
- (void) panelDidDisappear:(FLPanelViewController*) panel;

@end

@protocol FLPanelButtons <FLPanelArea>
@property (readonly, strong, nonatomic) NSButton* nextButton;
@property (readonly, strong, nonatomic) NSButton* backButton;
@property (readonly, strong, nonatomic) NSButton* otherButton;
@end

@protocol FLPanelHeader <FLPanelArea>
@property (readonly, strong, nonatomic) NSTextField* promptTextField;

@end

@interface FLPanelViewController : NSViewController  {
@private
    NSString* _prompt;
    BOOL _canOpenNextPanel;
    __unsafe_unretained FLPanelManager* _panelManager;
    __unsafe_unretained id _wizardViewController;
    id<FLPanelButtons> _buttons;
    id<FLPanelHeader> _header;
    BOOL _panelFillsView;
    BOOL _authenticated;
    BOOL _independent;
    BOOL _hidden;
    BOOL _enabled;
    id _identifier;
    __unsafe_unretained id _delegate;
}
@property (readwrite, strong, nonatomic) id identifier;

@property (readwrite, assign, nonatomic) id delegate;
@property (readwrite, assign, nonatomic) id wizardViewController;
@property (readwrite, strong, nonatomic) id<FLPanelButtons> buttons;
@property (readwrite, strong, nonatomic) id<FLPanelHeader> header;
@property (readwrite, strong, nonatomic) NSString* prompt;

@property (readwrite, assign, nonatomic) BOOL canOpenNextPanel;
@property (readwrite, assign, nonatomic) BOOL panelFillsView;

@property (readwrite, assign, nonatomic, getter=isAuthenticated) BOOL authenticated;
@property (readwrite, assign, nonatomic, getter=isIndependent) BOOL independent;
@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readwrite, assign, nonatomic, getter=isEnabled) BOOL enabled;

- (void) panelWillAppear;
- (void) panelDidAppear;
- (void) panelWillDisappear;
- (void) panelDidDisappear;

- (void) respondToNextButton:(BOOL*) handledIt;
- (void) respondToBackButton:(BOOL*) handledIt;
- (void) respondToOtherButton:(BOOL*) handledIt;

- (void) didMoveToPanelManager:(FLPanelManager*) manager;

- (void) addPanelView:(SDKView*) panelView toPanelArea:(id<FLPanelArea>) panelArea animated:(BOOL) animated;

- (void) showAlertWithError:(NSError*) error; 
- (void) showAlertWithError:(NSError*) error withTitle:(NSString*) title;
- (void) showAlertWithError:(NSError*) error withTitle:(NSString*) title withCaption:(NSString*) caption;
 
- (void) didHideAlertWithError:(NSError*) error;

- (void) showAlertWithTitle:(NSString*) title;
- (void) showAlertWithTitle:(NSString*) title withCaption:(NSString*) caption;

+ (id) defaultPanelIdentifier;

@end



