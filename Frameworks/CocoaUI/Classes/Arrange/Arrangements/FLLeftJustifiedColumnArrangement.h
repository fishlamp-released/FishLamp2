//
//  FLLeftJustifiedColumnArrangement.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLArrangement.h"


// uses the existing sizes of the views and aligns them in the
// bounds from the left to right. Widths of columns are not adjusted.
// returns size of enclosing bounds adjusted for columns
@interface FLLeftJustifiedColumnArrangement : FLArrangement 
@end