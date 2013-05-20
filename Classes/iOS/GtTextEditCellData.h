//
//	GtTextEditCellData.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/31/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTextInputTraits.h"
#import "GtCallbackObject.h"

// pass this in as cell data to configure the edit cell

@interface GtTextEditCellData : NSObject {
	NSUInteger m_maxLength;
	GtTextInputTraits* m_traits;
	GtCallbackObject* m_callback;
}

@property (readwrite, retain, nonatomic) GtTextInputTraits* textInputTraits;
@property (readwrite, retain, nonatomic) GtCallbackObject* callback;

- (id) init;

+ (GtTextEditCellData*) textEditCellData;

@end
