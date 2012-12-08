//
//	FLPathUtilities.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/16/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void FLCreateRectPathWithCornerRadii(CGMutablePathRef path, CGRect rect, CGFloat topLeft, CGFloat topRight, CGFloat bottomRight, CGFloat bottomLeft);

NS_INLINE 
void FLCreateRectPath(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius) {
	FLCreateRectPathWithCornerRadii(path, rect, cornerRadius, cornerRadius, cornerRadius, cornerRadius);
}

#define FLCreateRectPath(path, rect, cornerRadius) FLCreateRectPathWithCornerRadii(path, rect, cornerRadius, cornerRadius, cornerRadius, cornerRadius )

extern void FLCreateRectPathWithTopArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void FLCreateRectPathWithRightArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void FLCreateRectPathWithBottomArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);
extern void FLCreateRectPathWithLeftArrow(CGMutablePathRef path, CGRect rect, CGPoint arrowPoint, CGFloat arrowSize, CGFloat cornerRadius);

extern void FLCreatePartialRectPathTop(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);
extern void FLCreatePartialRectPathLeft(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);
extern void FLCreatePartialRectPathRight(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);
extern void FLCreatePartialRectPathBottom(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius);

extern void FLCreateRectPathBackButtonShape(CGMutablePathRef path, CGRect rect, CGFloat cornerRadius, CGFloat pointSize);

typedef enum {
    FLTriangleCornerUpperLeft,
    FLTriangleCornerUpperRight,
    FLTriangleCornerBottomRight,
    FLTriangleCornerBottomLeft
} FLTriangleCorner;

extern void FLSetPathToTriangleInRectCorner(CGMutablePathRef path, 
    CGRect rect, 
    FLTriangleCorner cornerInRect);