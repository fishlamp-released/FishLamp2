//
//	FLRectLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/13/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "SDKRect.h"
#import "SDKPoint.h"

typedef enum {
	FLRectLayoutVerticalNone		  = 0,
	FLRectLayoutVerticalTop			= 10,
	FLRectLayoutVerticalTopThird,
	FLRectLayoutVerticalBottomThird,
	FLRectLayoutVerticalCentered,
	FLRectLayoutVerticalBottom,
	FLRectLayoutVerticalFill,
    FLRectLayoutVerticalFit
} FLRectLayoutVertical;

typedef enum { 
	FLRectLayoutHorizontalNone		  = 0,
	FLRectLayoutHorizontalLeft,
	FLRectLayoutHorizontalLeftThird,
	FLRectLayoutHorizontalLeftQuarter,
	FLRectLayoutHorizontalCentered,
	FLRectLayoutHorizontalRight,
	FLRectLayoutHorizontalRightThird,
	FLRectLayoutHorizontalRightQuarter,
	FLRectLayoutHorizontalFill,
    FLRectLayoutHorizontalFit
} FLRectLayoutHorizontal;

typedef struct FLRectLayout { 
	FLRectLayoutHorizontal horizontal:16;
	FLRectLayoutVertical vertical:16;
	SDKEdgeInsets insets;
} FLRectLayout;

extern const FLRectLayout FLRectLayoutNone;
extern const FLRectLayout FLRectLayoutFill;
extern const FLRectLayout FLRectLayoutAspectFit;
extern const FLRectLayout FLRectLayoutCentered;
extern const FLRectLayout FLRectLayoutCenteredTop;
extern const FLRectLayout FLRectLayoutCenteredBottom;

#if DEBUG

// These are are inlined for release build.

extern BOOL FLRectLayoutsAreEqual(FLRectLayout lhs,
                                   FLRectLayout rhs);

extern FLRectLayout FLRectLayoutMake(FLRectLayoutHorizontal horizontalLayout,
                                       FLRectLayoutVertical verticalLayout);

extern FLRectLayout FLRectLayoutMakeWithInsets(FLRectLayoutHorizontal horizontalLayout,
                                                 FLRectLayoutVertical verticalLayout,
                                                 SDKEdgeInsets insets);

extern FLRectLayout FLRectLayoutSetVertical(FLRectLayout rectLayout,
                                              FLRectLayoutVertical vertical);

extern FLRectLayout FLRectLayoutSetHorizontal(FLRectLayout rectLayout,
                                                FLRectLayoutHorizontal horizontal);

extern BOOL FLRectLayoutIsValid(FLRectLayout loc);

extern BOOL FLRectLayoutNotNone(FLRectLayout loc);

extern SDKRect FLRectLayoutRectInRect(
	SDKRect containerRect,
	SDKRect containeeRect,
    FLRectLayout rectLayout);

#endif 

extern SDKRect FLRectLayoutRectHorizonallyInRect(
	SDKRect containerRect,
	SDKRect containeeRect,
    FLRectLayout rectLayout);
	
extern SDKRect FLRectLayoutRectVerticallyInRect(
	SDKRect containerRect,
	SDKRect containeeRect,
    FLRectLayout rectLayout);
    
#if !DEBUG
#import "FLRectLayout_Inlines.h"
#endif

    

