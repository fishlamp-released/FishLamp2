//
//	FLPinEditingView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLPinEditingViewDelegate;

@interface FLPinEditingView : UIView {
@private
	NSMutableArray* _buttons;
	NSMutableArray* _numberLabels;
	UILabel* _titleLabel;
	id<FLPinEditingViewDelegate> _delegate;
	NSString* _pinToCheck;
	NSUInteger _attemptCount;
	NSUInteger _maxAttempts;
	BOOL _pinCheckMode;
	BOOL _checkingNewPinMode;
	
	UILabel* _errorLabel;
}

@property (readonly, retain, nonatomic) NSString* pinToCheckAgainst;
@property (readwrite, assign, nonatomic) id<FLPinEditingViewDelegate> delegate;
@property (readwrite, retain, nonatomic) UIColor* borderColor;
@property (readwrite, assign, nonatomic) CGFloat cornerRadius;
@property (readwrite, assign, nonatomic) CGFloat borderWidth;

@property (readonly, retain, nonatomic) NSString* pin;

- (void) setPinCheckMode:(NSString*) pinToCheck maxAttempts:(NSUInteger) maxAttempts;

@end

@protocol FLPinEditingViewDelegate <NSObject>
- (void) pinEditViewDidCancel:(FLPinEditingView*) pinEditingView;
- (void) pinEditView:(FLPinEditingView*) pinEditingView didSetPin:(NSString*) pin;
- (void) pinEditViewUserDidEnterCorrectPin:(FLPinEditingView*) pinEditingView;

@end