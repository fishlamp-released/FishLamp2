/*
 *  GtParserStack.c
 *  FishLamp
 *
 *  Created by Mike Fullerton on 5/17/11.
 *  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
 *
 */

#import "GtParserStack.h"
#import "GtStringBuilder.h"

NSString *const GtParserStackErrorDomain = @"GtParserStackErrorDomain";

GtParserStack* GtParserStackAlloc()
{
	GtParserStack* stack = malloc(sizeof(GtParserStack));
	stack->top = -1;
	return stack;
}

void GtParserStackFree(GtParserStack** stack)
{
	while(GtParserStackPop(*stack))
	{
	}
	
	free(*stack);
	*stack = nil;
}

#if DEBUG
void GtParserStackLogState(GtParserStack* stack, NSString* why)
{
	GtStringBuilder* builder = [GtStringBuilder stringBuilder];
	
	[builder appendLineWithFormat:@"Logging parser stack: %@", why];
	[builder appendLineWithFormat:@"depth: %d", stack->top];
	if(stack->top >= 0)
	{
        for(int i = 0; i <= stack->top; i++)
		{
			GtParserStackNode* node = &(stack->stack[i]);
			[builder appendLineWithFormat:@"%i: key: %@, class: %@",i, node->key, NSStringFromClass([node->object class])];
		}
	}

	GtLog(@"%@", [builder buildString]);
}
#endif 
