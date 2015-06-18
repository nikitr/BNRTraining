//
//  main.m
//  ProperNames
//
//  Created by Nikita Rau on 6/17/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Read in a file as a huge string (ignoring the possibility of an error)
        NSString *nameString =
                    [NSString stringWithContentsOfFile:@"/usr/share/dict/propernames"
                                              encoding:NSUTF8StringEncoding error:NULL];
        
        NSString *wordString =
                    [NSString stringWithContentsOfFile:@"/usr/share/dict/words"
                                  encoding:NSUTF8StringEncoding error:NULL];
        
        
        // Break it into an array of strings
        NSArray *names = [nameString componentsSeparatedByString:@"\n"];
        NSArray *words = [wordString componentsSeparatedByString:@"\n"];
        
        // Go through the arrays one string at a time
        for (NSString *w in words)
        {
//            for (NSString *w in words)
//            {
//                if ([n isEqualToString:w]) {
//                    NSLog(@"%@ is a proper noun and regular word", n);
//                }
//            }
            BOOL isThere = [names containsObject:w];
            if (isThere) {
                NSLog(@"%@ is a proper noun and regular word", w);
            }
        }
    }
    return 0;
}
