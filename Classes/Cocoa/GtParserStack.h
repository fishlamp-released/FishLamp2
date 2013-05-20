/*
 *  GtParserStack.h
 *  FishLamp
 *
 *  Created by Mike Fullerton on 5/17/11.
 *  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
 *
 */

#import <Foundation/Foundation.h>

#define GtParserStackMaxDepth 128

extern NSString *const GtParserStackErrorDomain;

typedef enum {
	GtParserStackErrorCodeStackOverflow = 1
} GtParserStackErrorCode;

typedef struct {	
	NSString* key;
	id object;
} GtParserStackNode;

typedef struct {
	NSInteger top;
    GtParserStackNode stack[GtParserStackMaxDepth];
} GtParserStack;

extern GtParserStack* GtParserStackAlloc();
extern void GtParserStackFree(GtParserStack** stack);

NS_INLINE
void GtParserStackSetNodeObject(GtParserStackNode* node, id object)
{
	GtAssignObject((node->object), object);
}

NS_INLINE
void GtParserStackPush(GtParserStack* stack, id key, id object)
{
	if(stack->top + 1 >= GtParserStackMaxDepth)
	{
		GtThrowError([NSError errorWithDomain:GtParserStackErrorDomain code:GtParserStackErrorCodeStackOverflow userInfo:nil]);
	}

	++stack->top;
	stack->stack[stack->top].key = GtRetain(key);
	stack->stack[stack->top].object = GtRetain(object);
}

NS_INLINE
BOOL GtParserStackPop(GtParserStack* stack)
{
	if(stack->top >= 0)
	{
		GtReleaseWithNil((stack->stack[stack->top].key));
		GtReleaseWithNil((stack->stack[stack->top].object));
		--stack->top;
		return YES;
	}
	
	return NO;
}

NS_INLINE
GtParserStackNode* GtParserStackTop(GtParserStack* stack)
{
	return stack->top >= 0 ? &(stack->stack[stack->top]) : nil;
}

NS_INLINE
NSString* GtParserStackTopKey(GtParserStack* stack)
{
	return stack->top >= 0 ? stack->stack[stack->top].key : nil;
}

NS_INLINE
BOOL GtParserStackIsEmpty(GtParserStack* stack)
{
	return stack->top < 0;
}

NS_INLINE
BOOL GtParserStackIsFull(GtParserStack* stack)
{
	return stack->top + 1 >= GtParserStackMaxDepth;
}

NS_INLINE
NSInteger GtParserStackDepth(GtParserStack* stack)
{
	return stack->top + 1;
}

#if DEBUG
extern void GtParserStackLogState(GtParserStack* stack, NSString* why);
#endif 

