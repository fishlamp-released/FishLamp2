//
//	FLDebug
//	FishLampiPhone
//
//	Created by Mike Fullerton on 10/14/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if DEBUG
extern BOOL FLIsRunningInSimulator();

extern void FLLogViewHierarchy(UIView* view);
extern void FLLogAllWindows();

extern void FLLogView(UIView* view);
extern void FLLogScrollView(UIView* view);


#endif