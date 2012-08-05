//
//  FLColumnArrangement.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLArrangement.h"

// this lays out columns within the bounds - it adjusts
// the widths of each column to fit. You can specifiy a single
// column FLArrangeableFillModeFlexibleWidth in a single column's 
// (view or widget or whatever) 
@interface FLSingleRowColumnArrangement : FLArrangement {}
@end