//
//  FLSingleRowColumnArrangement.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLArrangement.h"

/*
	FLSingleRowColumnArrangement
	1. this stacks the view top to bottom (back to front in subviewList)
	2. makes each view as wide as parent view (minus arrangementInsets and margins)
	3. setViewSize sets height of view to bottom of last view + arrangementInsets + margins
*/ 
@interface FLSingleColumnRowArrangement : FLArrangement
@end
