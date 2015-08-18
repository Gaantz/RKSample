//
//  ViewController.m
//  RKSample
//
//  Created by Cristian Palomino Rivera on 16/08/15.
//  Copyright (c) 2015 Cristian Palomino Rivera. All rights reserved.
//

#import "Info.h"
#import "Clase.h"
#import "Quality.h"
#import "Type.h"
#import "Race.h"
#import "Locale.h"
#import "Set.h"
#import "Faction.h"

#import "ViewController.h"
#import "RKRelationshipMapping.h"
#import <RestKit/CoreData.h>
#import <RestKit/RestKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize RestKit
    NSURL *baseURL = [NSURL URLWithString:@"https://omgvamp-hearthstone-v1.p.mashape.com"];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    
    
    // Initialize managed object model from bundle
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    // Initialize managed object store
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithManagedObjectModel:managedObjectModel];
    objectManager.managedObjectStore = managedObjectStore;
    
    
    // Complete Core Data stack initialization
    [managedObjectStore createPersistentStoreCoordinator];
    NSString *storePath = [RKApplicationDataDirectory() stringByAppendingPathComponent:@"HeartDB.sqlite"];
    NSString *seedPath = [[NSBundle mainBundle] pathForResource:@"HeartDB" ofType:@"sqlite"];
    NSError *error;
    NSPersistentStore *persistentStore = [managedObjectStore addSQLitePersistentStoreAtPath:storePath fromSeedDatabaseAtPath:seedPath withConfiguration:nil options:nil error:&error];
    NSAssert(persistentStore, @"Failed to add persistent store with error: %@", error);
    
    // Create the managed object contexts
    [managedObjectStore createManagedObjectContexts];
    
    // Configure a managed object cache to ensure we do not create duplicate objects
    managedObjectStore.managedObjectCache = [[RKInMemoryManagedObjectCache alloc] initWithManagedObjectContext:managedObjectStore.persistentStoreManagedObjectContext];

    
    [objectManager.HTTPClient setDefaultHeader:@"X-Mashape-Key" value:@"BRGxteEFzFmshQItCIFu8g5ntVrKp15JpkFjsnr8kbh1losdFD"];
    
    
    RKEntityMapping *mapperInfo = [RKEntityMapping mappingForEntityForName:@"Info" inManagedObjectStore:managedObjectStore];
    [mapperInfo addAttributeMappingsFromDictionary:@{@"patch":@"patch"}];
    
    RKObjectMapping *mapperClase = [RKEntityMapping mappingForEntityForName:@"Clase" inManagedObjectStore:managedObjectStore];
    [mapperClase addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                          toKeyPath:@"name"]];
    
    RKObjectMapping *mapperSet = [RKEntityMapping mappingForEntityForName:@"Set" inManagedObjectStore:managedObjectStore];
    [mapperSet addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                          toKeyPath:@"name"]];
    
    RKObjectMapping *mapperType = [RKEntityMapping mappingForEntityForName:@"Type" inManagedObjectStore:managedObjectStore];
    [mapperType addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                          toKeyPath:@"name"]];
    
    RKObjectMapping *mapperFaction = [RKEntityMapping mappingForEntityForName:@"Faction" inManagedObjectStore:managedObjectStore];
    [mapperFaction addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                          toKeyPath:@"name"]];
    
    RKObjectMapping *mapperQuality = [RKEntityMapping mappingForEntityForName:@"Quality" inManagedObjectStore:managedObjectStore];
    [mapperQuality addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                          toKeyPath:@"name"]];
    
    RKObjectMapping *mapperRace = [RKEntityMapping mappingForEntityForName:@"Race" inManagedObjectStore:managedObjectStore];
    [mapperRace addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                          toKeyPath:@"name"]];
    
    RKObjectMapping *mapperLocale = [RKEntityMapping mappingForEntityForName:@"Locale" inManagedObjectStore:managedObjectStore];
    [mapperLocale addPropertyMapping:[RKAttributeMapping attributeMappingFromKeyPath:nil
                                                                          toKeyPath:@"name"]];
    
    
    [mapperInfo addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"classes"
                                                                               toKeyPath:@"classes"
                                                                             withMapping:mapperClase]];
    [mapperInfo addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"sets"
                                                                               toKeyPath:@"sets"
                                                                             withMapping:mapperSet]];
    [mapperInfo addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"types"
                                                                               toKeyPath:@"types"
                                                                             withMapping:mapperType]];
    [mapperInfo addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"factions"
                                                                               toKeyPath:@"factions"
                                                                             withMapping:mapperFaction]];
    [mapperInfo addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"qualities"
                                                                               toKeyPath:@"qualities"
                                                                             withMapping:mapperQuality]];
    [mapperInfo addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"races"
                                                                               toKeyPath:@"races"
                                                                             withMapping:mapperRace]];
    [mapperInfo addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"locales"
                                                                               toKeyPath:@"locales"
                                                                             withMapping:mapperLocale]];
    
    
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:mapperInfo
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/info"
                                                keyPath:nil
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [objectManager addResponseDescriptor:responseDescriptor];

    [[RKObjectManager sharedManager] getObjectsAtPath:@"/info"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  Info *info = [mappingResult firstObject];
                                                  NSLog(@"%@",[info.races allObjects]);
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                              }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
