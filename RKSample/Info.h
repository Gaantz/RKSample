//
//  Info.h
//  RKSample
//
//  Created by Cristian Palomino Rivera on 17/08/15.
//  Copyright (c) 2015 Cristian Palomino Rivera. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Info : NSManagedObject

@property (nonatomic, retain) NSString * patch;
@property (nonatomic, retain) NSSet *classes;
@property (nonatomic, retain) NSSet *sets;
@property (nonatomic, retain) NSSet *types;
@property (nonatomic, retain) NSSet *factions;
@property (nonatomic, retain) NSSet *qualities;
@property (nonatomic, retain) NSSet *races;
@property (nonatomic, retain) NSSet *locales;
@end

@interface Info (CoreDataGeneratedAccessors)

- (void)addClassesObject:(NSManagedObject *)value;
- (void)removeClassesObject:(NSManagedObject *)value;
- (void)addClasses:(NSSet *)values;
- (void)removeClasses:(NSSet *)values;

- (void)addSetsObject:(NSManagedObject *)value;
- (void)removeSetsObject:(NSManagedObject *)value;
- (void)addSets:(NSSet *)values;
- (void)removeSets:(NSSet *)values;

- (void)addTypesObject:(NSManagedObject *)value;
- (void)removeTypesObject:(NSManagedObject *)value;
- (void)addTypes:(NSSet *)values;
- (void)removeTypes:(NSSet *)values;

- (void)addFactionsObject:(NSManagedObject *)value;
- (void)removeFactionsObject:(NSManagedObject *)value;
- (void)addFactions:(NSSet *)values;
- (void)removeFactions:(NSSet *)values;

- (void)addQualitiesObject:(NSManagedObject *)value;
- (void)removeQualitiesObject:(NSManagedObject *)value;
- (void)addQualities:(NSSet *)values;
- (void)removeQualities:(NSSet *)values;

- (void)addRacesObject:(NSManagedObject *)value;
- (void)removeRacesObject:(NSManagedObject *)value;
- (void)addRaces:(NSSet *)values;
- (void)removeRaces:(NSSet *)values;

- (void)addLocalesObject:(NSManagedObject *)value;
- (void)removeLocalesObject:(NSManagedObject *)value;
- (void)addLocales:(NSSet *)values;
- (void)removeLocales:(NSSet *)values;

@end
