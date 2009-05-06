//
//  NSErrorAdditions.m
//  SRD
//
//  Created by Roberto Gamboni on 11/19/08.
//  Copyright 2008 Roberto Gamboni. All rights reserved.
//

#import "NSErrorAdditions.h"


@implementation NSError (SRD)

+ (NSError*) errorWithDomain: (NSString*) domain code: (NSInteger) code localizedDescription: (NSString*) description
{
	NSDictionary* userInfo = nil;
	if (description != nil)
		userInfo = [NSDictionary dictionaryWithObjectsAndKeys: description, NSLocalizedDescriptionKey, nil];
	return [self errorWithDomain: domain code: code userInfo: userInfo];
}

@end
