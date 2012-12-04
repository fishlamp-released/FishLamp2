//
//	FLPathUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/16/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void FLCreateRectPathWithCornerRadii(CGMutablePathRef path, FLRect rect, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight, CGFloat bottomLeft);

NS_INLINE 
void FLCreateRectPath(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius) {
	FLCreateRectPathWithCornerRadii(path, rect, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
}

#define FLCreateRectPath(path, rect, cornerRadius) FLCreateRectPathWithCornerRadii(path, rect, cornerRadius, cornerRadius, cornerRadius, cornerRadius )

extern void FLCreateRectPathWithTopArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void FLCreateRectPathWithRightArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void FLCreateRectPathWithBottomArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void FLCreateRectPathWithLeftArrow(CGMutablePathRef path, FLRect rect, FLPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);

extern void FLCreatePartialRectPathTop(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius);
extern void FLCreatePartialRectPathLeft(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius);
extern void FLCreatePartialRectPathRight(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius);
extern void FLCreatePartialRectPathBottom(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius);

extern void FLCreateRectPathBackButtonShape(CGMutablePathRef path, FLRect rect, CGFloat cornerRadius, CGFloat pointSize);

typedef enum {
    FLTriangleCornerUpperLeft,
    FLTriangleCornerUpperRight,
    FLTriangleCornerBottomRight,
    FLTriangleCornerBottomLeft
} FLTriangleCorner;

extern void FLSetPathToTriangleInRectCorner(CGMutablePathRef path, 
    FLRect rect, 
    FLTriangleCorner cornerInRect);