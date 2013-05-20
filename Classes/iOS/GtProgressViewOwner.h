//
//	GtProgressOwner.h
//	ZenApi1.4
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtProgressProtocol.h"

@class NSView;

@interface GtProgressViewOwner : NSObject {
@private
	id m_progressView;
}

@property (readwrite, retain, nonatomic) id progressView;

- (id) initWithProgressView:(id) progressView;

+ (GtProgressViewOwner*) progressViewOwner:(NSView<GtProgressProtocol>*) progressView;

@end
