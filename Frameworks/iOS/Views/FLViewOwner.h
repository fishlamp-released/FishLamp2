//
//	FLViewOwner.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>


@interface FLViewOwner : NSObject {
	UIView* _view;
}

@property (readwrite, retain, nonatomic) UIView* view;

+ (FLViewOwner*) viewOwner:(UIView*) progressView;
- (id) initWithView:(UIView*) progressView;

@end