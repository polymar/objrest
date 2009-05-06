//
//  NSDataAdditions.h
//  SRD
//
//  Created by Roberto Gamboni on 11/19/08.
//  Copyright 2008 Roberto Gamboni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Openovo)

/*! Returns the MD5 Hash Digest of the bytes currently available. !*/
- (NSData *)md5Digest;

/*! Returns the SHA-1 Hash Digest of the bytes currently available. !*/
- (NSData *)sha1Digest;

/*! Returns the hex value of the current bytes. !*/
- (NSString *)hexStringValue;

/*! Encodes the current bytes in base 64. !*/
- (NSString *)base64Encoded;

/*! Decodes the current bytes from base 64. !*/
- (NSData *)base64Decoded;

@end
