//
//  TagDataSource.m
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "TagDataSource.h"

@interface TagDataSource ()
@property(strong, nonatomic) NSManagedObjectContext *context;
@end

@implementation TagDataSource

- (instancetype)initWithContext:(NSManagedObjectContext *)context {
    self = [super init];
    if (self) {
        _context = context;
        _tags = [self sortedTagsByNameInContext:context];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:_context];
    }
    return self;
}


- (void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)contextChanged:(NSNotification *)note {
    self.tags = [self sortedTagsByNameInContext:self.context];
}

- (NSArray *)sortedTagsByNameInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Tag"];
    NSSortDescriptor *alphaAsc = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = @[alphaAsc];
    NSArray *tags = [context executeFetchRequest:request error:nil];
    return tags;
}

// MARK: UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                                            forIndexPath:indexPath];
    NSManagedObject *tag = self.tags[indexPath.row];
    NSString *name = [tag valueForKey:@"name"];
    cell.textLabel.text = name;
    return cell;
}

@end

