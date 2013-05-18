//
//  GtDebug.h
//  FishLampiPhone
//
//  Created by Mike Fullerton on 10/14/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#if DEBUG
extern BOOL GtIsRunningInSimulator();

extern void GtLogViewHierarchy(UIView* view);
extern void GtLogAllWindows();

#endif