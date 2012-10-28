//
//  FLDrawingUtils.h
//  FishLamp-iOS
//
//  Created by Mike Fullerton on 5/14/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

extern void FLDrawLinearGradient(CGContextRef context, 
    FLRect rect, 
    CGColorRef startColor, 
    CGColorRef endColor);
   
typedef struct {
    FLPoint startPoint; 
    FLPoint endPoint; 
    CGFloat width;
    CGLineCap cap;
    CGColorRef color;
} FLLine_t;    
      
extern void FLDrawLine(CGContextRef context, FLLine_t line);    

NS_INLINE
CGContextRef FLPushContext() {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
    return context;
}

NS_INLINE 
void FLPopContext(CGContextRef context) {
	CGContextRestoreGState(context);
}