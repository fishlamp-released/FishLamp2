//
//	FLViewOwner.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FLViewOwner : NSObject {
	UIView* _view;
}

@property (readwrite, retain, nonatomic) UIView* view;

+ (FLViewOwner*) viewOwner:(UIView*) progressView;
- (id) initWithView:(UIView*) progressView;

@end