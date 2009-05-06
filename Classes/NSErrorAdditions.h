//
//  NSErrorAdditions.h
//  SRD
//
//  Created by Roberto Gamboni on 11/19/08.
//  Copyright 2008 Roberto Gamboni. All rights reserved.
//

#import <Foundation/NSError.h>


@interface NSError (SRD)

+ (NSError*) errorWithDomain: (NSString*) domain code: (NSInteger) code localizedDescription: (NSString*) description;

@end
