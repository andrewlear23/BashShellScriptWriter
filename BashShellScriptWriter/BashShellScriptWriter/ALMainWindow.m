//
//  ALMainWindow.m
//  BashShellScriptWriter
//
//  Created by Andrew Lear on 05/09/2014.
//  Copyright (c) 2014 Andrew Lear. All rights reserved.
//

#import "ALMainWindow.h"

@implementation ALMainWindow

-(IBAction)generate:(id)sender {
    // NSLog(@"Test");
    
    //if (self.tbInput.)
    NSLog(@"%@", [[self.tbInput textStorage] string]);
    
    
    NSString *input = [[self.tbInput textStorage]string];
    NSString *filepath = [self.tfFilename stringValue];
    
    if ([[input stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"You need to specify an input"];
        [alert addButtonWithTitle:@"Ok"];
        [alert runModal];
        return;
        
    }
    if ([[filepath stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""]) {
        // input empty
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"You need to specify a file path"];
        [alert addButtonWithTitle:@"Ok"];
        [alert runModal];
        return;
    }
    
    [[self.tbOutput textStorage] setAttributedString:[[NSAttributedString alloc] initWithString:@""]];
    
    NSArray *excludes = [NSArray arrayWithObjects:@"$", @"\"", @"!", @"\\", @"`", nil];
    
    NSArray *lines = [input componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < [lines count]; i++) {
        NSString *line = [lines objectAtIndex:i];
        
        NSMutableString *escapedLine = [NSMutableString stringWithString:@""];
        
        for (int j = 0; j < [line length]; j++) {
            if ([excludes containsObject:[NSString stringWithFormat:@"%c", [line characterAtIndex:j]]]) {
                // escape
                if ([line characterAtIndex:j] == '!') {
                    if ([line rangeOfString:@"#!"].location != NSNotFound) {
                        [escapedLine appendFormat:@"%c", [line characterAtIndex:j]];
                    } else {
                        [escapedLine appendFormat:@"\\%c", [line characterAtIndex:j]];
                    }
                } else {
                    [escapedLine appendFormat:@"\\%c", [line characterAtIndex:j]];
                }
            } else {
                
                // just add
                [escapedLine appendFormat:@"%c", [line characterAtIndex:j]];
            }
        }
        NSAttributedString *attrStr;
        if (i == 0) {
            attrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"echo \"%@\" > %@\n",escapedLine, [filepath stringByReplacingOccurrencesOfString:@" " withString:@"\\ "]]];
        } else {
            attrStr = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"echo \"%@\" >> %@\n",escapedLine, [filepath stringByReplacingOccurrencesOfString:@" " withString:@"\\ "]]];
        }
       
        [[self.tbOutput textStorage] appendAttributedString:attrStr];
        
        
    }
    
    
    
}



@end
