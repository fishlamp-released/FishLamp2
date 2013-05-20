//
//  GtTextEditCellData.h
//  MyZen
//
//  Created by Mike Fullerton on 12/31/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtTextInputTraits.h"
#import "GtSimpleCallback.h"

// pass this in as cell data to configure the edit cell

@interface GtTextEditCellData : NSObject {
    NSUInteger m_maxLength;
	GtTextInputTraits* m_traits;
    GtSimpleCallback* m_callback;
}

@property (readwrite, assign, nonatomic) GtTextInputTraits* textInputTraits;
@property (readwrite, assign, nonatomic) GtSimpleCallback* callback;

- (id) init;

+ (GtTextEditCellData*) textEditCellData;

@end
