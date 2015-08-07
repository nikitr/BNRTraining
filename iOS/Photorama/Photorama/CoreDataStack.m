//
//  CoreDataStack.m
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "CoreDataStack.h"

@interface CoreDataStack ()
@property(copy, nonatomic) NSString *modelName;
@property(strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@end

@implementation CoreDataStack

- (instancetype)initWithModelName:(NSString *)modelName {
    self = [super init];
    if (self) {
        _modelName = [modelName copy];
        
        // Set up the managed object model
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:self.modelName withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        // Set up the persistent store coordinator
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        NSString *fileName = [self.modelName stringByAppendingPathExtension:@"sqlite"];;
        NSURL *storeURL = [[self appDocumentsDirectory] URLByAppendingPathComponent:fileName];
        NSError *storeError = nil;
        NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&storeError];
        NSAssert(store != nil, @"Fatal: couldn't instantiate the store. Bailing.");
        _persistentStoreCoordinator = psc;
        
        // Set up the main queue's managed object context
        NSManagedObjectContext *mqc = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        mqc.persistentStoreCoordinator = _persistentStoreCoordinator;
        mqc.name = @"Main Queue Context (UI Context)";
        _mainQContext = mqc;
    }
    return self;
}

- (NSURL *)appDocumentsDirectory {
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *docsURL = urls.firstObject;
    return docsURL;
}

- (BOOL)saveChanges:(NSError **)error {
    __block BOOL success = YES;
    [self.mainQContext performBlockAndWait:^{
        if (self.mainQContext.hasChanges) {
            success = [self.mainQContext save:error];
        }
    }];
    return success;
}

@end
