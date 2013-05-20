//
//	GtDebug.h
//	FishLampiPhone
//
//	Created by Mike Fullerton on 10/14/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if DEBUG
extern BOOL GtIsRunningInSimulator();

extern void GtLogViewHierarchy(UIView* view);
extern void GtLogAllWindows();

extern void GtLogView(UIView* view);
extern void GtLogScrollView(UIView* view);


#endif