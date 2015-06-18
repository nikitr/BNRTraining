//
//  main.m
//  PropertyList
//
//  Created by Nikita Rau on 6/18/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray *pets = [[NSMutableArray alloc] init];
        
        NSMutableDictionary *pet;
        
        
        // Dictionary relating animal to number of animals
        pet = [NSMutableDictionary dictionary]; // New pet dictionary is initialized
        [pet setObject:@"cat"
                forKey:@"animal"]; // This object belongs to the animal category
        [pet setObject:[NSNumber numberWithInt:1]
                forKey:@"num"]; // This object belongs to the number category
        [pets addObject:pet]; // The newly created pet dictionary is added to pets array
        
        pet = [NSMutableDictionary dictionary]; // Reinitialize the pet dictionary
        [pet setObject:@"dog"
                forKey:@"animal"];
        [pet setObject:[NSNumber numberWithInt:2]
                forKey:@"num"];
        [pets addObject:pet];
        
        [pets writeToFile:@"/tmp/pets.plist" atomically:YES];
        
        // Read the file in
        NSArray *petList = [NSArray arrayWithContentsOfFile:@"/tmp/pets.plist"];
        
        for (NSDictionary *d in petList) {
            if ([d objectForKey:@"num"] <= 1) {
                NSLog(@"I have %@ %@",
                      [d objectForKey:@"num"], [d objectForKey:@"animal"]);
            } else {
                NSLog(@"I have %@ %@s",
                      [d objectForKey:@"num"], [d objectForKey:@"animal"]);
            }
        }
       
    }
    return 0;
}
