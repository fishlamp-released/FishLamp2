//
//	FLDebug.h
//	FishLampiPhone
//
//	Created by Mike Fullerton on 10/14/09.
//	Copyright 2009 GreenTongue Software, LLC. All rights reserved.
//

#if DEBUG
extern BOOL FLIsRunningInSimulator();

extern void FLLogViewHierarchy(UIView* view);
extern void FLLogAllWindows();

extern void FLLogView(UIView* view);
extern void FLLogScrollView(UIView* view);


#endif