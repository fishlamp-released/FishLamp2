//
//	FLContentMode.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/13/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import "FishLampCocoa.h"
#import "FLRect.h"

typedef enum {
	FLContentModeVerticalNone		  = 0,
	FLContentModeVerticalTop			= 10,
	FLContentModeVerticalTopThird,
	FLContentModeVerticalBottomThird,
	FLContentModeVerticalCentered,
	FLContentModeVerticalBottom,
	FLContentModeVerticalFill,
    FLContentModeVerticalFit
} FLContentModeVertical;

typedef enum { 
	FLContentModeHorizontalNone		  = 0,
	FLContentModeHorizontalLeft,
	FLContentModeHorizontalLeftThird,
	FLContentModeHorizontalLeftQuarter,
	FLContentModeHorizontalCentered,
	FLContentModeHorizontalRight,
	FLContentModeHorizontalRightThird,
	FLContentModeHorizontalRightQuarter,
	FLContentModeHorizontalFill,
    FLContentModeHorizontalFit
} FLContentModeHorizontal;

typedef struct FLContentMode { 
	FLContentModeHorizontal horizontal:16;
	FLContentModeVertical vertical:16;
	FLEdgeInsets insets;
} FLContentMode;

extern const FLContentMode FLContentModeNone;
extern const FLContentMode FLContentModeFill;
extern const FLContentMode FLContentModeAspectFit;
extern const FLContentMode FLContentModeCentered;
extern const FLContentMode FLContentModeCenteredTop;
extern const FLContentMode FLContentModeCenteredBottom;

#if DEBUG

// These are are inlined for release build.

extern BOOL FLContentModesAreEqual(FLContentMode lhs,
                                   FLContentMode rhs);

extern FLContentMode FLContentModeMake(FLContentModeHorizontal horizontalLayout,
                                       FLContentModeVertical verticalLayout);

extern FLContentMode FLContentModeMakeWithInsets(FLContentModeHorizontal horizontalLayout,
                                                 FLContentModeVertical verticalLayout,
                                                 FLEdgeInsets insets);

extern FLContentMode FLContentModeSetVertical(FLContentMode contentMode,
                                              FLContentModeVertical vertical);

extern FLContentMode FLContentModeSetHorizontal(FLContentMode contentMode,
                                                FLContentModeHorizontal horizontal);

extern BOOL FLContentModeIsValid(FLContentMode loc);

extern BOOL FLContentModeNotNone(FLContentMode loc);

extern FLRect FLRectPositionRectInRectWithContentMode(
	FLRect containerRect,
	FLRect containeeRect,
    FLContentMode contentMode);

#endif 

extern FLRect FLRectPositionRectInRectHorizontallyWithContentMode(
	FLRect containerRect,
	FLRect containeeRect,
    FLContentMode contentMode);
	
extern FLRect FLRectPositionRectInRectVerticallyWithContentMode(
	FLRect containerRect,
	FLRect containeeRect,
    FLContentMode contentMode);
    
#if !DEBUG
#import "_FLContentMode.h"
#endif

    

