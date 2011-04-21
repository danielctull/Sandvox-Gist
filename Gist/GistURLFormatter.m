//
//  GistURLFormatter.m
//  FormatterTest
//
//  Created by Abizer Nasir on 20/04/2011.
//  Copyright 2011 Jungle Candy Software. All rights reserved.
//
//
// Copyright 2011 Abizer Nasir t/a Jungle Candy Software. All rights reserved.
 
// Redistribution and use in source and binary forms, with or without modification, are
// permitted provided that the following conditions are met:
 
// 1. Redistributions of source code must retain the above copyright notice, this list of
//    conditions and the following disclaimer.
 
// 2. Redistributions in binary form must reproduce the above copyright notice, this list
//    of conditions and the following disclaimer in the documentation and/or other materials
//    provided with the distribution.
 
// THIS SOFTWARE IS PROVIDED BY JUNGLE CANDY SOFTWARE ``AS IS'' AND ANY EXPRESS OR IMPLIED
// WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
// FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
// CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
// ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
// NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
// ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
// The views and conclusions contained in the software and documentation are those of the
// authors and should not be interpreted as representing official policies, either expressed
// or implied, of Abizer Nasir or of Jungle Candy Software.
//

#import "GistURLFormatter.h"

@interface GistURLFormatter ()

BOOL isNumeric(NSString *aString);

@end


@implementation GistURLFormatter

#pragma mark - Set up and tear down.

- (id)init {
    self = [super init];
    if (!self) {
        return nil; // Bail!
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark - NSFormatter required methods

- (NSString *)stringForObjectValue:(id)anObject {
    // Just return the string.
    return anObject;
}

- (BOOL)getObjectValue:(id *)anObject forString:(NSString *)theString errorDescription:(NSString **)errorDescription {
    // Valid inputs are of the form (there are more cases that can be covered, but this will do for now):
    // 1. A string of digits corresponding the the Gist ID eg. 12345
    // 2. A URL (with or without https://) that includes the gist domain eg. gist.github.com/12345
    // 3. A URL (with or without https://) that includes the gist domain and the sha of a particular revision, although the sha is stripped eg. gist.github.com/12345/a234c345e…
    
    NSArray *urlComponents = [theString componentsSeparatedByString:@"/"];
    
    if (!([urlComponents count])) {
        if (errorDescription) {
            *errorDescription = @"Empty field";
        }
        return NO;
    }
    
    NSInteger gistIdIndex;
    
    if ([urlComponents count] == 1) {
        gistIdIndex = 0;
    } else {
        //NSInteger baseIndex = [urlComponents indexOfObject:@"gist.github.com"];
        NSUInteger baseIndex = [urlComponents indexOfObjectPassingTest:^ BOOL (id obj, NSUInteger idx, BOOL *stop) {
            return ([obj caseInsensitiveCompare:@"gist.github.com"] == NSOrderedSame);
        }];
        if (baseIndex == NSNotFound || baseIndex == [urlComponents count] - 1) {
            if (errorDescription) {
                *errorDescription = @"Not a valid Gist URL";
            }
            return NO;
        }
        gistIdIndex = baseIndex + 1;
    }
    
    NSString *gistId = [urlComponents objectAtIndex:gistIdIndex];
    if (!(isNumeric(gistId)) || !([gistId length])) {
        if (errorDescription) {
            *errorDescription = @"Not a valid Gist URL";
        }
        return NO;
    }
    
    if (anObject) {
        *anObject = gistId;
    }
    
    return YES;
}

- (BOOL)isPartialStringValid:(NSString *)partialString newEditingString:(NSString **)newString errorDescription:(NSString **)error {
    // Don't want to validate partial strings
    return YES;
}

#pragma mark - Private functions

BOOL isNumeric(NSString *aString) {
    NSCharacterSet *charactersInString = [NSCharacterSet characterSetWithCharactersInString:aString];
    
    if (!([[NSCharacterSet decimalDigitCharacterSet] isSupersetOfSet:charactersInString])) {
        return NO;
    }
    return YES;
}


@end
