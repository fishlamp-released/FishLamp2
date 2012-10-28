/*
 *  FLParserStack.c
 *  FishLamp
 *
 *  Created by Mike Fullerton on 5/17/11.
 *  Copyright 2011 GreenTongue Software. All rights reserved.
 *
 */

#import "FLParserStack.h"
#import "FLStringBuilder.h"

NSString *const FLParserStackErrorDomain = @"FLParserStackErrorDomain";

FLParserStack* FLParserStackAlloc()
{
	FLParserStack* stack = malloc(sizeof(FLParserStack));
	stack->top = -1;
	return stack;
}

void FLParserStackFree(FLParserStack** stack)
{
	while(FLParserStackPop(*stack))
	{
	}
	
	free(*stack);
	*stack = nil;
}

#if DEBUG
void FLParserStackLogState(FLParserStack* stack, NSString* why)
{
	FLStringBuilder* builder = [FLStringBuilder stringBuilder];
    [builder appendLineWithFormat:@"Logging parser stack: %@", why];
    [builder appendLineWithFormat:@"depth: %d", stack->top];
    if(stack->top >= 0)
    {
        for(int i = 0; i <= stack->top; i++)
        {
            FLParserStackNode* node = &(stack->stack[i]);
            [builder appendLineWithFormat:@"%i: key: %@, class: %@",i, node->key, NSStringFromClass([node->object class])];
        }
    }

	FLCDebugLog([builder buildString]);
}
#endif 
