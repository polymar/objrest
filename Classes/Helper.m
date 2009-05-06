//
//  FormatUtil.m
//  Whozin
//
//  Created by Roberto Gamboni on 4/6/09.
//  Copyright 2009 AT&T Interactive. All rights reserved.
//
//TODO look if we can do something better with phone number.
//TODO Include all the format utilities for object NSDate.

#import "Helper.h"


@implementation Helper

+ (NSString*)formatPhoneNumber:(NSString*)numberToFormat
{
    // we assume there are really only about 10 digits, this overkill is to avoid stack overwrite
    int numberArray[128] = {};
    const char* string = [numberToFormat UTF8String];
	
    for( unsigned int i = 0; i < [numberToFormat length]; i++ )
    {   
        char miniString[2] = { string[i], 0 };
		
        // one character to a number
        numberArray[i] = strtol( miniString, NULL, 10 );
    }
    
    if( [numberToFormat length] == 10 )
        return [NSString stringWithFormat:@"(%d%d%d) %d%d%d-%d%d%d%d", numberArray[0], numberArray[1], numberArray[2], numberArray[3], numberArray[4], numberArray[5], numberArray[6], numberArray[7], numberArray[8], numberArray[9] ];
    
    // unformatted
    return numberToFormat;
}


@end
