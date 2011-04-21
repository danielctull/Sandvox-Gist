//
//  GistInspector.m
//  Gist
//
//  Created by Abizer Nasir on 21/04/2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "GistInspector.h"
#import "GistURLFormatter.h"


@implementation GistInspector
@synthesize gistIdField;

- (void)awakeFromNib {
    GistURLFormatter *formatter = [[GistURLFormatter alloc] init];
    [[self.gistIdField cell] setFormatter:formatter];
    [formatter release];
}
@end
