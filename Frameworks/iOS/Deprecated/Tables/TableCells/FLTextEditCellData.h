//
//	FLTextEditCellData.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/31/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTextInputTraits.h"
#import "FLCallbackObject.h"

// pass this in as cell data to configure the edit cell

@interface FLTextEditCellData : NSObject {
	NSUInteger _maxLength;
	FLTextInputTraits* _traits;
	FLCallbackObject* _callback;
}

@property (readwrite, retain, nonatomic) FLTextInputTraits* textInputTraits;
@property (readwrite, retain, nonatomic) FLCallbackObject* callback;

- (id) init;

+ (FLTextEditCellData*) textEditCellData;

@end
